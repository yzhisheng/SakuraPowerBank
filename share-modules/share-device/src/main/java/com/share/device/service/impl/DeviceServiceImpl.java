package com.share.device.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.share.common.core.domain.R;
import com.share.common.core.exception.ServiceException;
import com.share.common.core.utils.bean.BeanUtils;
import com.share.device.domain.*;
import com.share.device.service.*;
import com.share.rule.api.RemoteFeeRuleService;
import com.share.rule.domain.FeeRule;
import com.share.system.api.RemoteUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.geo.Circle;
import org.springframework.data.geo.Distance;
import org.springframework.data.geo.Metrics;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.geo.GeoJsonPoint;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@SuppressWarnings({"unchecked", "rawtypes"})
public class DeviceServiceImpl implements IDeviceService {

    @Autowired
    private MongoTemplate mongoTemplate;

    @Autowired
    private IStationService stationService;

    @Autowired
    private ICabinetService cabinetService;

    @Autowired
    private IMapService mapService;

    @Autowired
    private RemoteUserService remoteUserService;

/*    @Autowired
    private RemoteOrderInfoService remoteOrderInfoService;

    @Autowired
    private EmqxClientWrapper emqxClientWrapper;

    @Autowired
    private PowerBankUnlockHandler powerBankUnlockHandler;*/

    @Autowired
    private RemoteFeeRuleService remoteFeeRuleService;

    @Autowired
    private ICabinetSlotService cabinetSlotService;

    @Autowired
    private IPowerBankService powerBankService;

    //获取附近站点信息列表
    @Override
    public List<StationVo> nearbyStation(String latitude, String longitude) {
        //确定中心点
        //经度  和  纬度
        GeoJsonPoint geoJsonPoint =
                new GeoJsonPoint(Double.parseDouble(longitude),
                        Double.parseDouble(latitude));

        //设置查询半径，比如查询50公里
        Distance distance = new Distance(50, Metrics.KILOMETERS);

        //画圆
        Circle circle = new Circle(geoJsonPoint,distance);

        //查询mongoDB数据
        Query query = Query.query(Criteria.where("location").withinSphere(circle));
        List<StationLocation> list = mongoTemplate.find(query, StationLocation.class);
        if(CollectionUtils.isEmpty(list)){
            throw new ServiceException("附近没有站点信息.....");
        }

        //查询其他需要数据，进行封装
        //根据查询mongoDB的list集合里面获取站点其他数据
        // 从list获取所有站点id
        List<Long> stationIdList =
                list.stream().map(StationLocation::getStationId).collect(Collectors.toList());

        // 根据所有站点id获取对应站点数据  in(1,2,3)
        LambdaQueryWrapper<Station> wrapper = new LambdaQueryWrapper();
        wrapper.in(Station::getId,stationIdList);
        List<Station> stationList = stationService.list(wrapper);

        // List<Station> --  List<StationVo>
        List<StationVo> stationVoList = new ArrayList<>();
        //遍历
        stationList.forEach(station -> {
            // Station --  StationVo
            StationVo stationVo = new StationVo();
            BeanUtils.copyProperties(station,stationVo);

            //计算距离
            Double distanceStation = mapService.calculateDistance(longitude, latitude,
                    station.getLongitude().toString(),
                    station.getLatitude().toString());
            stationVo.setDistance(distanceStation);

            // 获取柜机信息
            Long cabinetId = station.getCabinetId();

            Cabinet cabinet = cabinetService.getById(cabinetId);
            //可用充电宝数量大于0，可借用
            if(cabinet.getAvailableNum() > 0) {
                stationVo.setIsUsable("1");
            } else {
                stationVo.setIsUsable("0");
            }
            // 获取空闲插槽数量大于0，可归还
            if (cabinet.getFreeSlots() > 0) {
                stationVo.setIsReturn("1");
            } else {
                stationVo.setIsReturn("0");
            }

            //获取站点规则数据
            Long feeRuleId = station.getFeeRuleId();
            R<FeeRule> feeRuleResult = remoteFeeRuleService.getFeeRule(feeRuleId);
            FeeRule feeRule = feeRuleResult.getData();
            String description = feeRule.getDescription();
            stationVo.setFeeRule(description);

            stationVoList.add(stationVo);
        });
        return stationVoList;
    }

    //门店详情
    @Override
    public StationVo getStation(Long id, String latitude, String longitude) {
        //根据门店id获取详情
        Station station = stationService.getById(id);
        //封装到StationVo
        StationVo stationVo = new StationVo();
        BeanUtils.copyProperties(station,stationVo);
        //当前位置距离门店距离
        Double distance = mapService.calculateDistance(longitude, latitude,
                station.getLongitude().toString(), station.getLatitude().toString());
        stationVo.setDistance(distance);

        // 获取柜机信息
        Cabinet cabinet = cabinetService.getById(station.getCabinetId());
        //可用充电宝数量大于0，可借用
        if(cabinet.getAvailableNum() > 0) {
            stationVo.setIsUsable("1");
        } else {
            stationVo.setIsUsable("0");
        }
        // 获取空闲插槽数量大于0，可归还
        if (cabinet.getFreeSlots() > 0) {
            stationVo.setIsReturn("1");
        } else {
            stationVo.setIsReturn("0");
        }

        // 获取费用规则
        FeeRule feeRule =
                remoteFeeRuleService.getFeeRule(station.getFeeRuleId()).getData();
        stationVo.setFeeRule(feeRule.getDescription());

        //返回数据
        return stationVo;
    }

    @Override
    public ScanChargeVo scanCharge(String cabinetNo) {
        return null;
    }

    //扫码充电接口
/*    @Override
    public ScanChargeVo scanCharge(String cabinetNo) {
        //1 远程调用：根据当前登录用户id查询用户信息，
        // 从用户信息获取是否支持免押金充电
        R<UserInfo> userInfoR = remoteUserService.getInfo(SecurityContextHolder.getUserId());
        UserInfo userInfo = userInfoR.getData();
        //判断
        if(userInfo == null) {
            throw new ServiceException("获取用户信息失败");
        }
        //判断是否免押金
        if("0".equals(userInfo.getDepositStatus())) {
            throw new ServiceException("未申请免押金使用");
        }

        ScanChargeVo scanChargeVo = new ScanChargeVo();
        //2 远程调用：判断用户是否有未完成订单
        R<OrderInfo> orderInfoR = remoteOrderInfoService.getNoFinishOrder(SecurityUtils.getUserId());
        OrderInfo orderInfo = orderInfoR.getData();
        if(orderInfo != null) {//有 未完成订单
            String status = userInfo.getStatus();
            if("0".equals(status)) {
                scanChargeVo.setStatus("2");
                scanChargeVo.setMessage("有未归还充电宝，请归还后使用");
                return scanChargeVo;
            }
            if("1".equals(status)) {
                scanChargeVo.setStatus("3");
                scanChargeVo.setMessage("有未支付订单，去支付");
                return scanChargeVo;
            }
        }

        //3 从柜机里面获取最优充电宝
        AvailableProwerBankVo availableProwerBankVo =
                this.checkAvailableProwerBank(cabinetNo);
        if(null == availableProwerBankVo) {
            throw new ServiceException("无可用充电宝");
        }
        if(!StringUtils.isEmpty(availableProwerBankVo.getErrMessage())) {
            throw new ServiceException(availableProwerBankVo.getErrMessage());
        }

        //4 把选择最优充电宝弹出
        // 使用MQTT弹出充电宝
        // 生成借取指令，弹出充电宝
        JSONObject object = new JSONObject();
        object.put("uId", SecurityContextHolder.getUserId());//SecurityUtils.getUserId()
        object.put("mNo", "mm"+ RandomUtil.randomString(8));
        object.put("cNo", cabinetNo);
        object.put("pNo", availableProwerBankVo.getPowerBankNo());
        object.put("sNo", availableProwerBankVo.getSlotNo());
        String topic = String.format(EmqxConstants.TOPIC_SCAN_SUBMIT, cabinetNo);
        String message = ProtocolConvertUtil.convertString(object);
        emqxClientWrapper.publish(topic, message);

        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }

        //5 返回封装需要数据
        scanChargeVo.setStatus("1");
        return scanChargeVo;
    }*/



    //获取柜机的充电宝信息
    private AvailableProwerBankVo checkAvailableProwerBank(String cabinetNo) {
        //1 创建AvailableProwerBankVo对象
        AvailableProwerBankVo availableProwerBankVo = new AvailableProwerBankVo();

        //2 根据cabinetNo柜机编号查询柜机信息
        Cabinet cabinet = cabinetService.getBtCabinetNo(cabinetNo);

        //3 判断柜机可用充电宝数量是否大于0
        Integer availableNum = cabinet.getAvailableNum();
        if(availableNum == 0) {
            availableProwerBankVo.setErrMessage("无可用充电宝");
            return availableProwerBankVo;
        }

        //4 根据柜机id查询插槽列表，返回list集合
        LambdaQueryWrapper<CabinetSlot> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CabinetSlot::getCabinetId,cabinet.getId());
        wrapper.eq(CabinetSlot::getStatus, "1");
        List<CabinetSlot> cabinetSlotList = cabinetSlotService.list(wrapper);

        //5 从第四步返回插槽列表list集合 获取对应充电宝id集合
        List<Long> powerBankIdList = cabinetSlotList.stream()
                .filter(item -> null != item.getPowerBankId())
                .map(CabinetSlot::getPowerBankId).collect(Collectors.toList());

        //6 根据充电宝id列表查询对应充电宝信息
        LambdaQueryWrapper<PowerBank> wrapperPowerBank = new LambdaQueryWrapper<>();
        wrapperPowerBank.in(PowerBank::getId,powerBankIdList);
        wrapperPowerBank.eq(PowerBank::getStatus,"1");
        List<PowerBank> powerBankList = powerBankService.list(wrapperPowerBank);
        //判断集合不为空
        if(CollectionUtils.isEmpty(powerBankList)) {
            availableProwerBankVo.setErrMessage("无可用充电宝");
            return availableProwerBankVo;
        }

        //7 把上一步获取充电宝信息集合进行排序（根据电量降序）
        if(powerBankList.size()>1) {
            Collections.sort(powerBankList,
                    (o1,o2)->o2.getElectricity().compareTo(o1.getElectricity()));
        }

        //8 获取电量最多充电宝信息
        PowerBank powerBank = powerBankList.get(0);

        //9 获取电量最多的充电宝对应插槽信息
        CabinetSlot cabinetSlot = cabinetSlotList.stream()
                .filter(item -> null != item.getPowerBankId()
                        && item.getPowerBankId().equals(powerBank.getId())).collect(Collectors.toList()).get(0);

        //10 锁定插槽（更新插槽状态）
        cabinetSlot.setStatus("2");
        cabinetSlotService.updateById(cabinetSlot);

        //11 返回需要vo数据
        availableProwerBankVo.setPowerBankNo(powerBank.getPowerBankNo());
        availableProwerBankVo.setSlotNo(cabinetSlot.getSlotNo());
        return availableProwerBankVo;
    }





//    @Override
//    public ScanChargeVo scanCharge(String cabinetNo) {
//        // 扫码充电返回对象
//        ScanChargeVo scanChargeVo = new ScanChargeVo();
//
//        //免押金判断
//        R<UserInfo> userInfoResult =  remoteUserService.getInfo(SecurityContextHolder.getUserId());
//        if (R.FAIL == userInfoResult.getCode()) {
//            throw new ServiceException(userInfoResult.getMsg());
//        }
//        UserInfo userInfo = userInfoResult.getData();
//        if (null == userInfo) {
//            throw new ServiceException("获取用户信息失败");
//        }
//        if("0".equals(userInfo.getDepositStatus())) {
//            throw new ServiceException("未申请免押金使用");
//        }
//
//        R<OrderInfo> orderInfoResult = remoteOrderInfoService.getNoFinishOrder(SecurityUtils.getUserId());
//        if (R.FAIL == orderInfoResult.getCode()) {
//            throw new ServiceException(orderInfoResult.getMsg());
//        }
//        OrderInfo orderInfo = orderInfoResult.getData();
//        if(null != orderInfo) {
//            if("0".equals(orderInfo.getStatus())) {
//                scanChargeVo.setStatus("2");
//                scanChargeVo.setMessage("有未归还充电宝，请归还后使用");
//                return scanChargeVo;
//            }
//            if("1".equals(orderInfo.getStatus())) {
//                scanChargeVo.setStatus("3");
//                scanChargeVo.setMessage("有未支付订单，去支付");
//                return scanChargeVo;
//            }
//        }
//
//        // 获取可用充电宝信息
//        AvailableProwerBankVo availableProwerBankVo = this.checkAvailableProwerBank(cabinetNo);
//        if(null == availableProwerBankVo) {
//            throw new ServiceException("无可用充电宝");
//        }
//        if(!StringUtils.isEmpty(availableProwerBankVo.getErrMessage())) {
//            throw new ServiceException(availableProwerBankVo.getErrMessage());
//        }
//
//        // 生成借取指令，弹出充电宝
//        JSONObject object = new JSONObject();
//        object.put("uId", SecurityContextHolder.getUserId());//SecurityUtils.getUserId()
//        object.put("mNo", "mm"+RandomUtil.randomString(8));
//        object.put("cNo", cabinetNo);
//        object.put("pNo", availableProwerBankVo.getPowerBankNo());
//        object.put("sNo", availableProwerBankVo.getSlotNo());
////        object.put("pNo", "cdb001");
////        object.put("sNo", "1");
//        String topic = String.format(EmqxConstants.TOPIC_SCAN_SUBMIT, cabinetNo);
//        String message = ProtocolConvertUtil.convertString(object);
//        emqxClientWrapper.publish(topic, message);
//
//        try {
//            Thread.sleep(2000);
//        } catch (InterruptedException e) {
//            throw new RuntimeException(e);
//        }
//
//        scanChargeVo.setStatus("1");
//        return scanChargeVo;
//    }
//
//    public AvailableProwerBankVo checkAvailableProwerBank(String cabinetNo) {
//        try {
//            AvailableProwerBankVo availableProwerBankVo = new AvailableProwerBankVo();
//
//            Cabinet cabinet = cabinetService.getBtCabinetNo(cabinetNo);
//            if(cabinet.getAvailableNum() == 0) {
//                availableProwerBankVo.setErrMessage("无可用充电宝");
//                return availableProwerBankVo;
//            }
//            // 获取插槽列表
//            List<CabinetSlot> cabinetSlotList = cabinetSlotService.list(new LambdaQueryWrapper<CabinetSlot>()
//                    .eq(CabinetSlot::getCabinetId, cabinet.getId())
//                    .eq(CabinetSlot::getStatus, "1") // 状态（1：占用 0：空闲 2：锁定）
//            );
//            // 获取插槽对应的充电宝id列表
//            List<Long> powerBankIdList = cabinetSlotList.stream()
//                    .filter(item -> null != item.getPowerBankId())
//                    .map(CabinetSlot::getPowerBankId).collect(Collectors.toList());
//            //获取可用充电宝列表
//            List<PowerBank> powerBankList =
//                    powerBankService.list(new LambdaQueryWrapper<PowerBank>()
//                            .in(PowerBank::getId, powerBankIdList)
//                            .eq(PowerBank::getStatus, "1"));
//            if(CollectionUtils.isEmpty(powerBankList)) {
//                availableProwerBankVo.setErrMessage("无可用充电宝");
//                return availableProwerBankVo;
//            }
//            // 根据电量降序排列
//            if(powerBankList.size() > 1) {
//                Collections.sort(powerBankList, (o1, o2) -> o2.getElectricity().compareTo(o1.getElectricity()));
//            }
//            // 获取电量最多的充电宝
//            PowerBank powerBank = powerBankList.get(0);
//            // 获取电量最多的充电宝插槽信息
//            CabinetSlot cabinetSlot = cabinetSlotList.stream().filter(item -> null != item.getPowerBankId() && item.getPowerBankId().equals(powerBank.getId())).collect(Collectors.toList()).get(0);
//            //锁定柜机卡槽
//            cabinetSlot.setStatus("2");
//            cabinetSlotService.updateById(cabinetSlot);
//
//            // 设置返回对象
//            availableProwerBankVo.setPowerBankNo(powerBank.getPowerBankNo());
//            availableProwerBankVo.setSlotNo(cabinetSlot.getSlotNo());
//
//            return availableProwerBankVo;
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
}

package com.share.device.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.share.device.domain.Region;
import com.share.device.mapper.RegionMapper;
import com.share.device.service.IRegionService;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class RegionServiceImpl extends ServiceImpl<RegionMapper, Region>
        implements IRegionService {

//    @Autowired
//    private RegionMapper regionMapper;

    //根据上级code获取下级数据列表
    @Override
    public List<Region> treeSelect(String code) {
        if (StringUtils.isEmpty(code)) {
            return List.of(); // 返回空列表
        }

        // 查询当前节点的所有子节点
        LambdaQueryWrapper<Region> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Region::getParentCode, code);
        List<Region> regionList = baseMapper.selectList(wrapper);

        if (!CollectionUtils.isEmpty(regionList)) {
            // 获取所有子节点的code
            List<String> childCodes = regionList.stream()
                    .map(Region::getCode)
                    .toList();

            // 一次性查询所有子节点的子节点数量
            LambdaQueryWrapper<Region> wrapper1 = new LambdaQueryWrapper<>();
            wrapper1.in(Region::getParentCode, childCodes);
            List<Region> allChildRegions = baseMapper.selectList(wrapper1);

            // 统计每个子节点的子节点数量
            Map<String, Long> childCountMap = allChildRegions.stream()
                    .collect(Collectors.groupingBy(Region::getParentCode, Collectors.counting()));

            // 设置每个子节点的hasChildren属性
            regionList.forEach(region -> {
                region.setHasChildren(childCountMap.getOrDefault(region.getCode(), 0L) > 0);
            });
        }

        return regionList;
    }

    //根据编号返回对应名称
    @Override
    public String getNameByCode(String code) {
        if (StringUtils.isEmpty(code)) {
            return "";
        }
        Region region = baseMapper.selectOne(new LambdaQueryWrapper<Region>()
                .eq(Region::getCode,code).select(Region::getName));
        return (region != null) ? region.getName() : "";
    }
}

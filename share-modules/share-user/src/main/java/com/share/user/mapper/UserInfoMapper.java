package com.share.user.mapper;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.share.user.domain.UserCountVo;
import com.share.user.domain.UserInfo;

/**
 * 用户Mapper接口
 *
 * @author atguigu
 * @date 2025-02-17
 */
public interface UserInfoMapper extends BaseMapper<UserInfo>
{

    /**
     * 查询用户列表
     *
     * @param userInfo 用户
     * @return 用户集合
     */
    public List<UserInfo> selectUserInfoList(UserInfo userInfo);

    //统计2024年每个月注册人数
    //远程调用：统计用户注册数据
    List<UserCountVo> selectUserCount();
}

package com.share.user.api;

import com.share.common.core.constant.SecurityConstants;
import com.share.common.core.constant.ServiceNameConstants;
import com.share.common.core.domain.R;
import com.share.user.domain.UserInfo;
import com.share.user.factory.RemoteUserFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * 用户服务
 *
 * @author share
 */
@FeignClient(contextId = "remoteUserInfoService",
        value = ServiceNameConstants.SHARE_USER,
        fallbackFactory = RemoteUserFallbackFactory.class)
public interface RemoteUserService
{

    @GetMapping("/userInfo/wxLogin/{code}")
    public R<UserInfo> wxLogin(@PathVariable("code") String code);

    @GetMapping(value = "/userInfo/getUserInfo/{id}")
    public R<UserInfo> getInfo(@PathVariable("id") Long id);

    /////////////
    @GetMapping("/userInfo/getUserCount")
    public R getUserCount();
}

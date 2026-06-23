package com.ruoyi.smartpart.mapping;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.RegisterBody;
import com.ruoyi.common.core.domain.model.TenantBody;
import com.ruoyi.smartpart.domain.vo.msUser.RenterInsert;
import com.ruoyi.smartpart.domain.vo.room.TenantInfoVo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.TargetType;
import org.mapstruct.factory.Mappers;

@Mapper
public interface SysUserMapping {
    SysUserMapping INSTANCE = Mappers.getMapper(SysUserMapping.class);

    TenantBody toPreview(SysUser sysUser);

    //转 用户信息确认Vo
    @Mapping(source = "nickName" ,target = "realName")
    @Mapping(source = "idNum",target = "idCard")
    TenantInfoVo toInfo(SysUser sysUser);

    RegisterBody toRenter(RenterInsert renterInsert);
}

package com.ruoyi.smartpart.mapping;

import com.ruoyi.smartpart.domain.entity.TenantApplication;
import com.ruoyi.smartpart.domain.query.TenantApplication.TenantApplicationSaveQuery;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface TenantApplicationMapping {
    TenantApplicationMapping INSTANCE = Mappers.getMapper(TenantApplicationMapping.class);

    TenantApplication toEntity(TenantApplicationSaveQuery query);
}

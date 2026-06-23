package com.ruoyi.smartpart.mapping;

import com.ruoyi.smartpart.domain.entity.LeaseCancellation;
import com.ruoyi.smartpart.domain.query.Contract.LeaseCancellationQuery;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface LeaseCancellationMapping {

    LeaseCancellationMapping INSTANCE = Mappers.getMapper(LeaseCancellationMapping.class);

    LeaseCancellation toInsert(LeaseCancellationQuery leaseCancellationQuery);

}

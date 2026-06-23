package com.ruoyi.smartpart.mapping;

import com.ruoyi.smartpart.domain.entity.Contract;
import com.ruoyi.smartpart.domain.query.Contract.ContractChangeQuery;
import com.ruoyi.smartpart.domain.query.Contract.ContractInsertQuery;
import com.ruoyi.smartpart.domain.query.Contract.ContractUpdataQuery;
import com.ruoyi.smartpart.domain.vo.Contract.ContracPreviewtListVo;
import com.ruoyi.smartpart.domain.vo.Contract.ContractInsertVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;
@Mapper
public interface ContractMapping {

    ContractMapping INSTANCE = Mappers.getMapper(ContractMapping.class);



    Contract toInsert(ContractInsertQuery contractInsertQuery);
    Contract toUpdata(ContractUpdataQuery contractUpdataQuery);
    Contract toChange(ContractChangeQuery contractChangeQuery);

    ContracPreviewtListVo toSet(Contract contract);


}

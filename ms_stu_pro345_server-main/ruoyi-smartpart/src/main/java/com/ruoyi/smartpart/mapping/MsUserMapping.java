package com.ruoyi.smartpart.mapping;

import com.ruoyi.smartpart.domain.entity.Bill;
import com.ruoyi.smartpart.domain.entity.MsUser;
import com.ruoyi.smartpart.domain.query.Bill.BillInsertQuery;
import com.ruoyi.smartpart.domain.query.Bill.TenantBillQuery;
import com.ruoyi.smartpart.domain.query.Bill.TenantBillQueryById;
import com.ruoyi.smartpart.domain.query.msUser.RenterUpdate;
import com.ruoyi.smartpart.domain.vo.Bill.BillDetailVo;
import com.ruoyi.smartpart.domain.vo.msUser.RenterDetailVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface MsUserMapping {

    MsUserMapping INSTANCE = Mappers.getMapper(MsUserMapping.class);

    RenterDetailVo toDetail(MsUser msUser);

    MsUser toEntity(RenterUpdate renterUpdate);
}

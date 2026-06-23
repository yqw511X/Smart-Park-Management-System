package com.ruoyi.smartpart.utils;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collections;
import java.util.List;

// 分页结果封装
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PageDTO<V> {

    @ApiModelProperty("总条数")
    private Long total;

    @ApiModelProperty("总页数")
    private Long pages;

    @ApiModelProperty("集合")
    private List<V> list;

    public static <PO,VO> PageDTO<VO> of(Page<PO> p, Class<VO> clazz){
        PageDTO<VO> dto = new PageDTO<>();
        // 1 总条数
        dto.setTotal(p.getTotal());
        // 2 总页数
        dto.setPages(p.getPages());
        // 3 当前页数据
        List<PO> records = p.getRecords();
        if (CollUtil.isEmpty(records)){
            dto.setList(Collections.emptyList());
            return dto;
        }
        // 4.拷贝user的VO
        dto.setList(BeanUtil.copyToList(records,clazz));

        // 4.返回
        return dto;

    }

    public static <PO,VO> PageDTO<VO> of(IPage<PO> p, Class<VO> clazz){
        PageDTO<VO> dto = new PageDTO<>();
        // 1 总条数
        dto.setTotal(p.getTotal());
        // 2 总页数
        dto.setPages(p.getPages());
        // 3 当前页数据
        List<PO> records = p.getRecords();
        if (CollUtil.isEmpty(records)){
            dto.setList(Collections.emptyList());
            return dto;
        }
        // 4.拷贝user的VO
        dto.setList(BeanUtil.copyToList(records,clazz));

        // 4.返回
        return dto;

    }
}

import request from '@/utils/request'

// 维修端查询工单列表
export function repairManList(params) {
  return request({
    url: '/repair-order/repairMan/list',
    method: 'get',
    params
  })
}

//维修工端查询详细信息
export function orderDetail(repairOrderId) {
  return request({
    url:`/repair-order/worker/${repairOrderId}`,
    method: 'get',
  })
}

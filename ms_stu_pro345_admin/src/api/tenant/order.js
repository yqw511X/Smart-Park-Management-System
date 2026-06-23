import request from '@/utils/request'

// 查询我的报修列表(分页)
export function listMyOrder(query) {
  return request({
    url: '/repair-order/me',
    method: 'get',
    params: query
  })
}

// 新建报修
export function myOrderCreate(data) {
  return request({
    url: '/repair-order/create',
    method: 'post',
    data
  })
}

// 修改报修
export function myOrderUpdate(data) {
  return request({
    url: '/repair-order/update',
    method: 'post',
    data
  })
}

// 取消报修
export function myOrderCancel(data) {
  return request({
    url: '/repair-order/cancel',
    method: 'put',
    data
  })
}

//根据id查询工单
export function orderDetail(repairOrderId) {
  return request({
    url:`/repair-order/${repairOrderId}`,
    method: 'get',
  })
}
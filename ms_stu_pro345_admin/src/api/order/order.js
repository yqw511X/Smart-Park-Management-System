import request from '@/utils/request'

// 查询工单信息列表（姓名）
export function listOrder(query) {
  return request({
    url: '/repair-order/list',
    method: 'get',
    params: query
  })
}

// 查询工单报修信息详情(ID)
export function orderInfo(repairOrderId) {
  return request({
    url: `/repair-order/${repairOrderId}`,
    method: 'get',
  })
}

// 查询工单维修进度
export function orderProgress(repairOrderId) {
  return request({
    url: `/repair-order/progress/${repairOrderId}`,
    method: 'get',
  })
}

// 查询工单维修日志
export function orderLog(repairOrderId) {
  return request({
    url: `/repair-order/repair-info/${repairOrderId}`,
    method: 'get',
  })
}

// 查询维修工列表
export function repairManName() {
  return request({
    url: '/repair-order/repairMan/name',
    method: 'get',
  })
}

//指派员工
export function assignOrder(data) {
  return request({
    url: '/repair-order/assign',
    method: 'post',
    data
  })
}


import request from '@/utils/request'

// 查询数据概览
export function workbenchdata(query) {
  return request({
    url: '/workbench/overview',
    method: 'get',
    params: query
  })
}

// 图表-已收款
export function paidchart(query) {
  return request({
    url: '/workbench/chart/paid',
    method: 'get',
    params: query
  })
}

// 图表-应收款
export function receivablechart(query) {
  return request({
    url: '/workbench/chart/receivable',
    method: 'get',
    params: query
  })
}

// 图表-未收款
export function unpaidchart(query) {
  return request({
    url: '/workbench/chart/unpaid',
    method: 'get',
    params: query
  })
}
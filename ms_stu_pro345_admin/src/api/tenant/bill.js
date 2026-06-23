import request from '@/utils/request'

// 查询账单信息列表(分页)
export function listMyBill(query) {
  return request({
    url: '/tenant/bill/list',
    method: 'get',
    params: query
  })
}

//付款
export function myBillPay(query) {
  return request({
    url: '/tenant/bill/pay',
    method: 'post',
    params: query,
  })
}
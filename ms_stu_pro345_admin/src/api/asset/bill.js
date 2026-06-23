import request from '@/utils/request'

// 查询账单信息列表(分页)
export function listBill(query) {
  return request({
    url: '/bill/list',
    method: 'get',
    params: query
  })
}

//删除账单信息
export function deleteBill(billIds) {
    return request({
        url: `/bill/${billIds}`,
        method: 'delete'
    })
}

// 确认收款
export function surePay(query) {
  return request({
    url: '/bill/pay',
    method: 'post',
    params: query
  })
}


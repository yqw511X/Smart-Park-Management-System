import request from '@/utils/request'

// 查询租赁申请审批信息列表
export function listApplication(params) {
  return request({
    url: '/renter/approveRenterStatus',
    method: 'GET',
    params
  })
}

// 审批通过
export function approveRenterPass(data) {
  return request({
    url: '/renter/approveRenterPass',
    method: 'POST',
    data
  })
}
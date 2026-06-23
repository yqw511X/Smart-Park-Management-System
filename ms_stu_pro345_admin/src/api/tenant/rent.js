import request from '@/utils/request'

// 查询房间信息列表(分页)
export function listMyRent(query) {
  return request({
    url: '/tenant/application/room/list',
    method: 'get',
    params: query
  })
}

// 获取租户个人信息
export function tenantInfo() {
  return request({
    url: '/tenant/application/info',
    method: 'get',
  })
}

// 提交租房申请
export function rentApply(data) {
  return request({
    url: '/tenant/application/submit',
    method: 'post',
    data
  })
}

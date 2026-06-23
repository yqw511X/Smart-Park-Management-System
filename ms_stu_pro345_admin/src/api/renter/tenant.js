import request from '@/utils/request'

// 查询租户信息列表（姓名）
export function listRenter(query) {
  return request({
    url: '/renter/all',
    method: 'get',
    params: query
  })
}

// 新增租户
export function addRenter(data) {
  return request({
    url: '/renter/add',
    method: 'post',
    data: data
  })
}

// 查询租户信息列表(ID)
export function listRenterId(userId) {
  return request({
    url: `/renter/${userId}`,
    method: 'get',
  })
}

//批量删除租户信息
export function deleteRenter(userIds) {
    return request({
        url: `/renter/${userIds}`,
        method: 'delete'
    })
}

//编辑租户信息
export function editRenter(data) {
  return request({
    url: '/renter/update',
    method: 'put',
    data: data
  })
}
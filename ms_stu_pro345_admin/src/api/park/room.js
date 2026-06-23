import request from '@/utils/request'

// 查询房间列表(分页)
export function listRoom(query) {
  return request({
    url: '/room',
    method: 'get',
    params: query
  })
}

// 创建房间
export function addRoom(data) {
  return request({
    url: '/room',
    method: 'post',
    data: data
  })
}

//编辑房间
export function editRoom(data) {
  return request({
    url: '/room',
    method: 'put',
    data: data
  })
}

// 查询房间详情(回显)
export function roomDetail(roomIds) {
  return request({
    url: `/room/${roomIds}`,
    method: 'get',
  })
}

//删除房间（批量）
export function deleteRoom(roomId) {
    return request({
        url: `/room/${roomId}`,
        method: 'delete'
    })
}

// 查询租赁情况
export function roomRecord(roomId) {
  return request({
    url: `/room/record/${roomId}`,
    method: 'get',
  })
}

//修改房间是否上架
export function roomStatus(data) {
  return request({
    url: '/room/status',
    method: 'put',
    data: data
  })
}
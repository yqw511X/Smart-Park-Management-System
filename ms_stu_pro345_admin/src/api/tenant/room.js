import request from '@/utils/request'

// 查询房间信息列表(分页)
export function listMyRoom(query) {
  return request({
    url: '/tenant/room/list',
    method: 'get',
    params: query
  })
}

//取消申请
export function cancelRoom(applicationId) {
    return request({
        url: `/tenant/room/cancel/${applicationId}`,
        method: 'put'
    })
}

//合同详情
export function roomContract(roomId) {
    return request({
        url: `/tenant/room/contract/${roomId}`,
        method: 'put'
    })
}
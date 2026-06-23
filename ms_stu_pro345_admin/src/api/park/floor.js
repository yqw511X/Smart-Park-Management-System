import request from '@/utils/request'

// 查询楼层列表
export function listFloor(buildingId) {
    return request({
        url: `/floor/${buildingId}`,
        method: 'get'
    })
}

//新增楼层信息
export function addFloor(data) {
  return request({
    url: '/floor',
    method: 'post',
    data: data
  })
}

//编辑楼层
export function editFloor(data) {
  return request({
    url: '/floor',
    method: 'put',
    data: data
  })
}

//删除楼层（批量）
export function deleteFloor(floorIds) {
    return request({
        url: `/floor/${floorIds}`,
        method: 'delete'
    })
}

//查询楼层名称
export function listFloorName(buildingId) {
    return request({
        url: `/floor/name/${buildingId}`,
        method: 'get'
    })
}
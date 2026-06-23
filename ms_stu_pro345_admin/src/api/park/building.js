import request from '@/utils/request'

// 查询楼宇列表(分页)
export function listBuilding(query) {
  return request({
    url: '/building',
    method: 'get',
    params: query
  })
}

// 创建楼宇
export function addBuilding(data) {
  return request({
    url: '/building',
    method: 'post',
    data: data
  })
}

//编辑楼宇
export function editBuilding(data) {
  return request({
    url: '/building',
    method: 'put',
    data: data
  })
}

//删除楼宇（批量）
export function deleteBuilding(buildIds) {
    return request({
        url: `/building/${buildIds}`,
        method: 'delete'
    })
}

// 查询楼宇名称列表
export function listBuildingName() {
  return request({
    url: '/building/list',
    method: 'get',
  })
}
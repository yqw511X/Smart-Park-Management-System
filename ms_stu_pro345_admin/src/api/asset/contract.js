import request from '@/utils/request'

// 查询合同信息列表(分页)
export function listContract(query) {
  return request({
    url: '/contract/list',
    method: 'get',
    params: query
  })
}

//删除合同信息
export function deleteContract(contractIds) {
    return request({
        url: `/contract/${contractIds}`,
        method: 'delete'
    })
}

// 新增合同
export function addContract(data) {
  return request({
    url: '/contract',
    method: 'post',
    data: data
  })
}

// 签订合同
export function signContract(params) {
  return request({
    url: '/contract/sign',
    method: 'post',
    params
  })
}


//合同编号生成
export function contractNum() {
  return request({
    url: '/contract/contractNum',
    method: 'get',
  })
}

//合同变更
export function contractChange(data) {
  return request({
    url: '/contract/change',
    method: 'put',
    data: data
  })
}


//合同编辑
export function contractUpdata(data) {
  return request({
    url: '/contract/updata',
    method: 'put',
    data: data
  })
}

//预览合同
export function contractPreview(query) {
  return request({
    url: '/contract/preview',
    method: 'get',
    params: query
  })
}

//预览账单界面
export function billPreview(query) {
  return request({
    url: '/contract/bill',
    method: 'get',
    params: query
  })
}

//分页查询新增功能下的房间信息列表
export function contractRoomList(query) {
  return request({
    url: '/contract/insert/roomList',
    method: 'get',
    params: query
  })
}

//分页查询新增功能下的租户信息列表
export function contractTenantList(query) {
  return request({
    url: '/contract/insert/tenantList',
    method: 'get',
    params: query
  })
}

//退租 功能
export function contractLease(data) {
  return request({
    url: '/contract/lease',
    method: 'put',
    data: data
  })
}
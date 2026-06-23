import request from '@/utils/request'

//支付功能的跳转到支付宝支付界面
export function alipay(query) {
  return request({
    url: '/api/alipay/pay',
    method: 'get',
    params: query
  })
}

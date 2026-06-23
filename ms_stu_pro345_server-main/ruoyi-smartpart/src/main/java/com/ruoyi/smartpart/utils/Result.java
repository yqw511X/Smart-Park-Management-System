package com.ruoyi.smartpart.utils;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

// 结果封装
@Data
public class Result<T> {

  @ApiModelProperty(value = "状态码")
  private int status;

  @ApiModelProperty(value = "提示信息")
  private String message;

  @ApiModelProperty(value = "数据")
  private T data;


  public static <T> Result<T> success(T data) {
    Result<T> result = new Result<>();
    result.setStatus(200);
    result.setMessage("操作成功!");
    result.setData(data);
    return result;
  }

  public static <T> Result<T> success(T data, String message) {
    Result<T> result = new Result<>();
    result.setStatus(200);
    result.setMessage(message);
    result.setData(data);
    return result;
  }

  public static <T> Result<T> fail( String message) {
    Result<T> result = new Result<>();
    result.setStatus(500);
    result.setMessage(message);
    return result;
  }

  public static <T> Result<T> fail(int code, String message) {
    Result<T> result = new Result<>();
    result.setStatus(code);
    result.setMessage(message);
    return result;
  }

}

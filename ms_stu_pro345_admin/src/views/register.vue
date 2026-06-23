<template>
  <div class="register">
    <el-form ref="registerForm" :model="registerForm" :rules="registerRules" class="register-form">
      <h3 class="title">智慧园区管理系统</h3>

      <!-- 角色类型 -->
      <el-form-item label="角色" prop="roleId">
        <el-select 
          v-model="registerForm.roleId" 
          placeholder="请选择角色"
          style="width: 100%"
        >
          <el-option label="租户" value="3" />
          <el-option label="维修工" value="4" />
        </el-select>
      </el-form-item>

      <!-- 用户名 -->
      <el-form-item prop="username">
        <el-input 
          v-model="registerForm.username" 
          type="text" 
          auto-complete="off" 
          placeholder="账户">
          <svg-icon 
            slot="prefix" 
            icon-class="user" 
            class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>

      <!-- 真实姓名 -->
      <el-form-item prop="nickname">
        <el-input 
          v-model="registerForm.nickname" 
          type="text" 
          auto-complete="off" 
          placeholder="真实姓名">
          <svg-icon 
            slot="prefix" 
            icon-class="user" 
            class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>

      <!-- 身份证号码 -->
      <el-form-item prop="idNum">
        <el-input 
          v-model="registerForm.idNum" 
          type="text" 
          auto-complete="off" 
          placeholder="身份证号码">
          <svg-icon 
            slot="prefix" 
            icon-class="user" 
            class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>

      <!-- 联系电话 -->
      <el-form-item prop="phonenumber">
        <el-input 
          v-model="registerForm.phonenumber" 
          type="text" 
          auto-complete="off" 
          placeholder="联系电话">
          <svg-icon 
            slot="prefix" 
            icon-class="user" 
            class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>

      <!-- 密码 -->
      <el-form-item prop="password">

          <!-- 密码强度指示器 -->
          <el-popover
            ref="popover"
            placement="right"
            width="200"
            trigger="focus"
            >

            <div v-if="this.passwordStrength >= 3">
              <span class="strength-strong">强度：强</span>
              <el-progress  :percentage="100" status="success"></el-progress>
              <span>请至少输入6个字符，请不要使用容易被猜到的字符</span>
            </div>
            
            <div v-else-if="this.passwordStrength == 2">
              <span class="strength-medium">强度：中</span>
              <el-progress  :percentage="60" status="warning"></el-progress>
              <span>请至少输入6个字符，请不要使用容易被猜到的字符</span>
            </div>

            <div v-else-if="this.passwordStrength <= 1">
              <span class="strength-weak">强度：弱</span>
              <el-progress  :percentage="10" status="exception"></el-progress>
              <span>请至少输入6个字符，请不要使用容易被猜到的字符</span>
            </div>
          </el-popover>
          
          <!-- 密码输入框 -->
          <el-input
              @click=""
              v-model="registerForm.password"
              type="password"
              auto-complete="off"
              placeholder="至少6位密码，区分大小写"
              @keyup.enter.native="handleRegister"
              v-popover:popover
            >
              <svg-icon 
                slot="prefix" 
                icon-class="password" 
                class="el-input__icon input-icon" />
            </el-input>
      </el-form-item>

      <!-- 确认密码 -->
      <el-form-item prop="passwords">
        <el-input
          v-model="registerForm.passwords"
          type="password"
          auto-complete="off"
          placeholder="确认密码"
          @keyup.enter.native="handleRegister"
        >
          <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>

      <!-- 验证码 -->
      <!-- <el-form-item prop="code" v-if="captchaEnabled">
        <el-input
          v-model="registerForm.code"
          auto-complete="off"
          placeholder="验证码"
          style="width: 63%"
          @keyup.enter.native="handleRegister"
        >
          <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
        </el-input>
        <div class="register-code">
          <img :src="codeUrl" @click="getCode" class="register-code-img"/>
        </div>
      </el-form-item> -->

      <!-- 已有账号跳转登录 -->
      <el-form-item style="width:100%;">
        <el-button
          :loading="loading"
          size="medium"
          type="primary"
          style="width:100%;"
          @click.native.prevent="handleRegister"
        >
          <span v-if="!loading">注 册</span>
          <span v-else>注 册 中...</span>
        </el-button>
        <div style="float: right;">
          <router-link class="link-type" :to="'/login'">使用已有账户登录</router-link>
        </div>
      </el-form-item>
    </el-form>

    <!--  底部  -->
    <div class="el-register-footer">
      <span></span>
    </div>
  </div>
</template>

<script>
import { getCodeImg, register } from "@/api/login";

export default {
  name: "Register",
  data() {

    // 初次密码校验规则
    const validatePass = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请输入必填字段'));
      }

      // 1. 基础长度检查
      if (value.length < 6) {
        callback(new Error('密码至少需要6个字符'));
      }

      // 2. 检查简单密码模式
      // 连续数字
      const sequentialNumbers = /(012|123|234|345|456|567|678|789|987|876|765|654|543|432|321|210){2,}/
      // 重复字符
      const repeatedChars = /(.)\1{2,}/
      // 键盘顺序
      const keyboardSequences = ['qwerty', 'asdfgh', 'zxcvbn', 'password', '123456']
      
      if (sequentialNumbers.test(value) || 
          repeatedChars.test(value) ||
          keyboardSequences.some(seq => value.toLowerCase().includes(seq))) {
        callback(new Error('请避免使用连续数字或重复字符'))
        return
      }

      // 3. 计算字符类型
      let typeCount = 0
      const types = {
        hasLower: /[a-z]/.test(value),
        hasUpper: /[A-Z]/.test(value),
        hasNumber: /\d/.test(value),
        hasSpecial: /[^A-Za-z0-9]/.test(value)
      }

      Object.values(types).forEach(hasType => {
        if (hasType) typeCount++;
        this.passwordStrength = typeCount;
      })

      // 4. 强度判断
      
      if (typeCount === 1) {
        callback(new Error('请至少包含两种字符类型（字母、数字、特殊符号）'));
      } else if (typeCount === 2) {
        // 强度为"中"，通过验证
        callback();
      } else if (typeCount >= 3) {
        // 强度为"高"，通过验证
        callback();
      } else {
        callback(new Error('密码不符合要求'));
      }
    };

    //再次输入密码校验
    const equalToPassword = (rule, value, callback) => {
      if (this.registerForm.password !== value) {
        callback(new Error("两次输入的密码不一致"));
      } else {
        callback();
      }
    };

    return {
      codeUrl: "",

      //注册表单校验
      registerForm: {
        roleId:"",
        username: "",
        nickName:"",
        idNum:"",
        phonenumber:"",
        password: "",
        passwords: "",
        code: "",
        uuid: ""
      },

      //注册表单校验规则
      registerRules:{
        roleId:[
          { 
            required: true, 
            message: '请选择角色', 
            trigger: 'blur'
          }
        ],
        nickname:[
          { 
            required: true, 
            message: '请输入必填字段', 
            trigger: 'blur'
          }
        ],
        realName:[
          { 
            required: true, 
            message: '请输入必填字段', 
            trigger: 'blur'
          }
        ],
        idNum:[
          { 
            required: true, 
            message: '请输入必填字段', 
            trigger: 'blur'
          }
        ],
        phonenumber:[
          { required: true, 
            message: '请输入必填字段', 
            trigger: 'blur'
          }
        ],
        password: [
          {
            max: 20,
            message: '密码最多20个字符',
            trigger: ['blur', 'change']
          },
          { 
            validator: validatePass, 
            trigger: ['blur', 'change'] 
          }
        ],
        passwords: [
          { required: true, 
            message: '请再次输入密码', 
            trigger: 'blur'
          },
          { 
            validator: equalToPassword, 
            trigger: ['blur', 'change'] 
          }
        ],
        // code: "",
        // uuid: ""
      },
      passwordStrength:0,
     // visible:true, //控制密码强度框显示
      loading: false,
      captchaEnabled: true,

    };
  },
  created() {
    this.getCode();
  },
  methods: {
    //获取验证码
    getCode() {
      getCodeImg().then(res => {
        this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled;
        if (this.captchaEnabled) {
          this.codeUrl = "data:image/gif;base64," + res.img;
          this.registerForm.uuid = res.uuid;
        }
      });
    },
  
    handleRegister() {
      this.$refs.registerForm.validate(valid => {
        if (valid) {
          this.loading = true;
          register(this.registerForm).then(res => {
            const username = this.registerForm.username;
            this.$alert("<font color='red'>恭喜你，您的账号 " + username + " 注册成功！</font>", '系统提示', {
              dangerouslyUseHTMLString: true,
              type: 'success'
            }).then(() => {
              this.$router.push("/login");
            }).catch(() => {});
          }).catch(() => {
            this.loading = false;
            if (this.captchaEnabled) {
              this.getCode();
            }
          })
        }
      });
    }
  }
};
</script>

<style rel="stylesheet/scss" lang="scss">
.register {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  background-image: url("../assets/images/login-background.jpg");
  background-size: cover;
}
.title {
  margin: 0px auto 30px auto;
  text-align: center;
  color: #707070;
}

.register-form {
  border-radius: 6px;
  background: #FFFFFF00;
  width: 400px;
  padding: 25px 25px 5px 25px;
  .el-input {
    height: 38px;
    input {
      height: 38px;
    }
  }
  .input-icon {
    height: 39px;
    width: 14px;
    margin-left: 2px;
  }
}
.strength-weak {
  color: #f5222d;
}
.strength-medium {
  color: #faad14;
}
.strength-strong {
  color: #52c41a;
}
.register-tip {
  font-size: 13px;
  text-align: center;
  color: #bfbfbf;
}
.register-code {
  width: 33%;
  height: 38px;
  float: right;
  img {
    cursor: pointer;
    vertical-align: middle;
  }
}
.el-register-footer {
  height: 40px;
  line-height: 40px;
  position: fixed;
  bottom: 0;
  width: 100%;
  text-align: center;
  color: #fff;
  font-family: Arial;
  font-size: 12px;
  letter-spacing: 1px;
}
.register-code-img {
  height: 38px;
}
</style>

<template>
    <div class="lease-edit-container">
        <div class="title">
                退租编辑
        </div>
        <div class="lease-edit-content">
            <div class="edit-content">
                <!-- 基本信息区域 -->
                <el-divider content-position="left">基本信息</el-divider>
                <div class="main-info">
                    <div class="list">
                        <el-row
                            :gutter="24"
                            class="row"
                            >
                            <el-col :span="8">
                                <div>合同编号：{{ mainInfoData.contractNum }}</div>
                            </el-col>
                            <el-col :span="8">
                                <div >合同名称：{{ mainInfoData.contractName }}</div>
                            </el-col>
                            <el-col :span="8">
                                <div >租户名称：{{ mainInfoData.nickName }}</div>
                            </el-col>
                        </el-row>
                    </div>
                </div>

                <!-- 租赁场地区域 -->
                <el-divider content-position="left">租赁场地</el-divider>
                <div class="rental-venue-info">
                    <el-table
                        :data="roomPreviewVoData"
                        style="width: 100%"
                        >
                        <el-table-column
                            prop="roomName"
                            label="房间名称"
                            width="180">
                        </el-table-column>
                        <el-table-column
                            prop="parkName"
                            label="所属园区"
                            width="180">
                        </el-table-column>
                        <el-table-column
                            prop="buildingName"
                            label="所属楼宇">
                        </el-table-column>
                        <el-table-column
                            prop="floorName"
                            label="所属楼层">
                        </el-table-column>
                        <el-table-column
                            prop="area"
                            label="收租面积（平方米）">
                        </el-table-column>
                    </el-table>
                </div>

                <!-- 退租信息区域 -->
                 <el-divider content-position="left">退租信息</el-divider>
                 <div class="lease-form">
                    <el-form 
                        :model="leaseForm" 
                        :rules="rules" 
                        ref="ruleForm" 
                        label-width="120px" 
                        class="demo-ruleForm"
                        
                        size="mini"
                        >
                        <!-- 退租日期 -->
                        <el-form-item 
                            label="退租日期" 
                            prop="tenantTime"
                            >
                            <el-date-picker
                                v-model="leaseForm.tenantTime"
                                type="date"
                                placeholder="选择日期"
                                >
                            </el-date-picker>
                        </el-form-item>

                        <!-- 退租原因 -->
                        <el-form-item 
                            label="退租原因" 
                            prop="leaseReason"
                            >
                             <el-select 
                                v-model="leaseForm.leaseReason" 
                                placeholder="请选择"
                                >
                                <el-option
                                    v-for="item in options"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value"
                                    >
                                </el-option>
                            </el-select>
                        </el-form-item>

                        <!-- 应收费用 -->
                        <el-form-item 
                            label="应收费用" 
                            prop="accountReceivable"
                            >
                            <el-input 
                                v-model="leaseForm.accountReceivable"
                                >
                            </el-input>
                        </el-form-item>

                        <!-- 应退费用 -->
                        <el-form-item 
                            label="应退费用" 
                            prop="refundFees"
                            >
                            <el-input 
                                v-model="leaseForm.refundFees"
                                >
                            </el-input>
                        </el-form-item>

                        <!-- 费用合计 -->
                        <el-form-item 
                            label="费用合计" 
                            prop="totalPay"
                            >
                            <el-input 
                                v-model="leaseForm.totalPay"
                                disabled
                                >
                            </el-input>
                        </el-form-item>

                        <!-- 备注 -->
                        <el-form-item 
                            label="备注（可选）" 
                            prop="name"
                            >
                            <el-input 
                                v-model="leaseForm.remark"
                                type="textarea"
                                :rows="4"
                                >
                            </el-input>
                        </el-form-item>
                        <el-form-item>
                            <div class="foot_btn">
                                <el-button 
                                    @click="goback"
                                    >
                                    返回
                                </el-button>
                                <el-button 
                                    type="primary" 
                                    @click="submitForm('ruleForm')"
                                    >
                                    提交
                                </el-button>
                            </div>
                        </el-form-item>
                    </el-form>
                 </div>
            </div>
           
        </div>
        
    </div>
</template>

<script>
import dayjs from 'dayjs';
import { contractPreview,contractLease } from '../../../api/asset/contract';
export default{
    name:'lease-edit',
    data(){
        return{
            contractId:null,//当前合同Id
            mainInfoData:{
                contractNum:'',
                contractName:'',
                nickName:''
            },
            roomPreviewVoData:[],
            leaseForm: {
                contractId:null,
                tenantTime:'',
                leaseReason:'',
                accountReceivable:null,
                refundFees:null,
                totalPay:null,
                remark:''
            },
            rules: {
                tenantTime: [
                    { type: 'date',required: true, message: '请选择退租日期', trigger: 'blur' },
                ],
                leaseReason: [
                    { required: true, message: '请选择退租原因', trigger: 'change' }
                ]
            },
            options: [
                {
                    value: '工作变动',
                    label: '工作变动'
                }, 
                {
                    value: '家庭因素',
                    label: '家庭因素'
                }, 
                {
                    value: '经济原因',
                    label: '经济原因'
                }, 
                {
                    value: '个人生活变动',
                    label: '个人生活变动'
                }
            ],
            rentInfo:{
                stratTime:'',
                dailyFee:null,//日管理费
                tenantMethod:'',//租金收租方法
                monthRent:null,//月租金
                dailyRent:null,//日租金
                tenantMoney:null,//总租金
                manageMoney:null,//总管理费
            }
        }
    },
    created(){
        this.initPage();
    },
    watch: {
        // 监听 message 的变化
        'leaseForm.tenantTime'(newVal, oldVal) {
            console.log(newVal);
            const newTime = dayjs(newVal).format('YYYY-MM-DD HH:mm:ss');
            this.calculateRent(newTime);
        },
    },
    methods:{
        //初始化页面
        initPage(){
            this.contractId = this.$route.query.contractId;
            this.leaseForm.contractId = this.$route.query.contractId
            this.getContractDetail();
        },

        //获取当前合同详情
        getContractDetail(){
            const queryData={
                contractId : this.contractId
            }
            contractPreview(queryData).then(res=>{
                console.log('当前获取合同详情',res);
                
                this.mainInfoData.contractNum = res.data.contractNum;
                this.mainInfoData.contractName = res.data.contractName;
                this.mainInfoData.nickName = res.data.tenantBody.nickName;
                this.roomPreviewVoData = [res.data.roomPreviewVo];
                this.rentInfo.stratTime = res.data.startTime;
                this.rentInfo.monthRent = res.data.monthRent;
                this.rentInfo.dailyRent = res.data.dailyRent;
                this.rentInfo.dailyFee = res.data.dailyFee;       
                this.rentInfo.tenantMethod = res.data.tenantMethod;
                 this.rentInfo.tenantMoney = res.data.tenantMoney;       
                this.rentInfo.manageMoney = res.data.manageMoney;                          
                console.log(this.rentInfo);
                            
            }).catch(()=>{

            })
        },

        //根据选择退租时间计算应收费用
        calculateRent(newTime){
            //计算应收租金
            const d1 = new Date(this.rentInfo.stratTime);
            const d2 = new Date(newTime);

            if (d2 < d1) {
                this.$message.error('结束日期不能早于开始日期');
                return
            }

            let totalRent = 0;
            const monthNum = Number(this.getMonthsDiffByDays(this.rentInfo.stratTime,newTime));
            const dayNum = Number(this.getDaysDiff(this.rentInfo.stratTime,newTime));
            //判断收租方法
            switch(this.rentInfo.tenantMethod) {
                case '0': // 按固定租金
                totalRent = monthNum * this.rentInfo.monthRent;
                break;
                case '1': // 按实际天数
                totalRent = dayNum * this.rentInfo.dailyRent;
                break;
                default:
                totalRent = 0;
            }

            // 计算应收管理费（先不调用 toFixed）
            const totalManage = dayNum * this.rentInfo.dailyFee;
            
            // 最后统一计算总和并格式化
            const realtotal = (Number(totalRent) || 0) + (Number(totalManage) || 0);
            const total = Number(this.rentInfo.tenantMoney) + Number(this.rentInfo.manageMoney);
            this.leaseForm.accountReceivable = total.toFixed(2);
            const refundtotal = Number(total)-Number(realtotal);
            this.leaseForm.refundFees = refundtotal.toFixed(2);
            this.leaseForm.totalPay = (total-refundtotal).toFixed(2)
        },

        //计算两个日期的相差天数
        getDaysDiff(date1, date2){
            const d1 = new Date(date1);
            const d2 = new Date(date2);
            // 计算毫秒差，转换为天数
            const diffTime = Math.abs(d2 - d1);
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
            
            return diffDays;
        },

        //计算两个日期相差的月份数
        getMonthsDiffByDays(date1, date2) {
            const days = this.getDaysDiff(date1, date2);
            return days / 30;
        },

        //提交退租申请
        submitForm(formName) {
            this.$refs[formName].validate((valid) => {
            if (valid) {
                console.log('退租请求负载',this.leaseForm);
                const leasetime = dayjs(this.leaseForm.tenantTime).format('YYYY-MM-DD HH:mm:ss')
                const leaseInfo={
                    contractId:this.leaseForm.contractId,
                    tenantTime:leasetime,
                    leaseReason:this.leaseForm.leaseReason,
                    accountReceivable:this.leaseForm.accountReceivable,
                    refundFees:this.leaseForm.refundFees,
                    totalPay:this.leaseForm.totalPay,
                    remark:this.leaseForm.remark,
                }
                contractLease(leaseInfo).then(res=>{
                    console.log('退租后端响应',res);
                    if(res.status==200){
                        this.$message.success(res.message);
                        setTimeout(() => {
                            this.$router.push({
                                path:'/assetManagement/contract'
                            })
                        }, 2000);
                    }else{
                        this.$message.error(res.message);
                    }
                }).catch(()=>{

                })
            } else {
                console.log('error submit!!');
                return false;
            }
            });
        },

        //跳转回合同界面
        goback(){
            this.$router.push({
                path:'/assetManagement/contract'
            })
        },
    }
}
</script>

<style lang="scss" scoped>
.lease-edit-container{
    box-sizing: border-box;
    background-color: #f1f2f6;
    
    .title{
        font-size: 18px;
        font-weight: bold;
        background-color: white;
        padding:20px 15px;
    }


    .lease-edit-content{
        box-sizing: border-box;
        padding: 20px;
        background-color: #f1f2f6;
        font-size:12px;
        color: #80817c;

        .edit-content{
            background-color: white;
            padding: 20px;
            box-sizing: border-box;

            .main-info{
                padding: 10px 90px;
            }

            .rental-venue-info{
                padding: 10px 90px;
            }

            .lease-form{
                padding: 10px 280px;

                .el-form-item {
                    margin-bottom: 35px;  /* 默认是22px，增大这个值增加高度间距 */
                }

                .foot_btn{
                    display: flex;
                    justify-content: center;
                }
            }
        }
    }
}
</style>
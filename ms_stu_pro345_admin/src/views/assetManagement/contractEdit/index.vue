<template>
    <div class="contract-edit-container">
        <div class="title">
                合同编辑
        </div>
        <div class="contract-edit-content">

            <div class="edit-content">
                 <el-steps 
                    class="steps"
                    size="mini" 
                    :active="active"
                    finish-status="success"
                    >
                    <el-step title="填写基础信息" ></el-step>
                    <el-step title="填写费项信息"></el-step>
                    <el-step title="完成"></el-step>
                </el-steps>

                <!-- 租户信息 -->
                <tenant-info
                    @tenant-event = "handleTenantEvent"
                    @area-event="getRoomArea"
                    @tenantinfo-event = "handleTenantInfoEvent"
                    v-show="active == 0"
                    :userId="userId"
                    :contractId="contractId"
                    :contractName="contractName"
                    :roomPreviewVo="roomPreviewVo"
                    :status="status"
                    >
                </tenant-info>
            
                <!-- 租赁信息 -->
                <rent-info
                    @rent-event = "handleRentEvent"
                    v-show="active == 1"
                    :area="roomArea"
                    :dateSign="dateSign"
                    :startOverTime="startOverTime"
                    :tenantUnitPrice="tenantUnitPrice"
                    :tenantType="tenantType"
                    :manageUnitPrice="manageUnitPrice"
                    :manageMoneyType="manageMoneyType"
                    :mortgageMonth="mortgageMonth"
                    :mortgagePay="mortgagePay"
                    :tenantMethod="tenantMethod"
                    :status="status"
                    :tenantInfo="tenantInfo"
                    >
                </rent-info>

                <!-- 结束信息 -->
                <finish-info
                    v-show="active == 2"
                    >
                </finish-info>
               
            </div>
           
        </div>
        
    </div>
</template>

<script>
import tenantInfo from "./components/tenant-info.vue"
import rentInfo from "./components/rent-info.vue"
import finishInfo from "./components/finish-info.vue";
import { contractPreview } from "../../../api/asset/contract";
export default{
    name:'contarct-edit',
    components: { tenantInfo,rentInfo,finishInfo},
    data(){
        return{
            status:'',//表单状态
            contractId:'',//合同id
            contractName:'',//合同名称
            remark:'',//备注
            userId:null,//用户id
            roomPreviewVo:{},
            dateSign:'',//签订日期
            startOverTime:[],//开始结束时间
            tenantUnitPrice:null,//租金单价
            tenantType:'',//租金类型
            tenantMethod:'',//租金计算方式
            manageUnitPrice:null,//管理费单价
            manageMoneyType:'',//管理费类型
            mortgagePay:null,//押付租金
            mortgageMonth:null,//押付月数
            active:0,
            roomArea:0,
            contractData:{},
            tenantInfo:{}
        }
    },
    created(){
        this.initPage();
    },
    methods:{
        //初始化页面
        initPage(){
            this.status = this.$route.query.status;
            console.log(this.status);
            //获取详情
            this.contractId = this.$route.query.contractId;
            if((this.status == 'edit'&&this.contractId != '')||(this.status == 'change'&&this.contractId != '')){
                this.getContractDetail();
            }
        },

        //根据ID查询合同的具体信息
        getContractDetail(){
            const queryData = {
                contractId:this.contractId
            };
            contractPreview(queryData).then(res=>{
                console.log('合同详情概览',res);
                this.contractData = res.data;
                this.userId = res.data.tenantBody.userId;
                this.contractName = res.data.contractName;
                this.dateSign = res.data.dateSign;
                const startOverTime = [res.data.startTime,res.data.overTime];
                this.startOverTime = startOverTime;
                this.remark = res.data.remark;
                this.tenantUnitPrice = res.data.tenantUnitPrice;
                this.tenantType = res.data.tenantType;
                this.tenantMethod = res.data.tenantMethod;
                this.roomPreviewVo = res.data.roomPreviewVo;
                this.manageUnitPrice = res.data.manageUnitPrice;
                this.manageMoneyType = res.data.manageMoneyType;
                this.mortgageMonth = res.data.mortgageMonth;
                this.mortgagePay = res.data.mortgagePay;
            }).catch(()=>{

            })
        },

        //租户信息子组件通信（跳转下一页）
        handleTenantEvent(data){
            this.active = data.active;
        },

        //租户信息子组件通信(收到信息数据)
        handleTenantInfoEvent(data){
            this.tenantInfo = data;
        },

        //获取子组件传递房间面积信息
        getRoomArea(data){
            this.roomArea = data.area;
        },

        //租金信息子组件通信
        handleRentEvent(data){
            this.active = data.active;
        }
    }
}
</script>

<style lang="scss" scoped>
.contract-edit-container{
    box-sizing: border-box;
    background-color: #f1f2f6;
    
    .title{
        font-size: 18px;
        font-weight: bold;
        background-color: white;
        padding:20px 15px;
    }


    .contract-edit-content{
        box-sizing: border-box;
        padding: 20px;
        background-color: #f1f2f6;

        .edit-content{
            background-color: white;
            padding: 20px;
            box-sizing: border-box;

            .steps{
                margin-bottom: 20px;
            }
        }
    }
}
</style>
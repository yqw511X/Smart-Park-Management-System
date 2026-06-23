<template>
    <div class="contract-info-container">

        <!-- 主要信息区域 -->
        <div class="main-info">
            <div class="little-tip">主要信息</div>
            <div class="list">
                <el-row
                    :gutter="24"
                    class="row"
                    >
                    <el-col :span="6">
                        <div>合同编号：{{ contractDetailInfo.contractNum }}</div>
                    </el-col>
                    <el-col :span="6">
                        <div >合同名称：{{ contractDetailInfo.contractName }}</div>
                    </el-col>
                    <el-col :span="6">
                        <div v-if="this.contractDetailInfo.status==0">合同状态：待签订</div>
                        <div v-if="this.contractDetailInfo.status==1">合同状态：执行中</div>
                        <div v-if="this.contractDetailInfo.status==2">合同状态：已完成</div>
                    </el-col>
                    <el-col :span="6">
                        <div>租赁期限：{{ rentTime }}</div>
                    </el-col>
                </el-row>
                <el-row class="row" :gutter="24">
                    <el-col :span="6">
                        <div>经办人：{{ contractDetailInfo.updateBy }}</div>
                    </el-col>
                    <el-col :span="6">
                        <div >合同版本：{{ contractDetailInfo.versionNum }}</div>
                    </el-col>
                    <el-col :span="6">
                        <div>备注：{{ contractDetailInfo.remark }}</div>
                    </el-col>
                    <el-col :span="6">
                        <div></div>
                    </el-col>
                </el-row>
            </div>
        </div>

        <el-divider></el-divider>

        <!-- 乙方信息区域 -->
        <div class="partB-info">
           <div class="little-tip">乙方</div>
            <div class="list">
                <el-row
                    :gutter="24"
                    class="row"
                    >
                    <el-col :span="12">
                        <div>租户名称：{{ contractDetailInfo.tenantBody && contractDetailInfo.tenantBody.nickName ? contractDetailInfo.tenantBody.nickName : '--' }}</div>
                    </el-col>
                    <el-col :span="12">
                        <div></div>
                    </el-col>
                </el-row>
                <el-row
                    :gutter="24"
                    class="row"
                    >
                    <el-col :span="12">
                        <div>身份证：{{ contractDetailInfo.tenantBody && contractDetailInfo.tenantBody.idNum ? contractDetailInfo.tenantBody.idNum : '--' }}</div>
                    </el-col>
                    <el-col :span="12">
                        <div >个人邮箱：{{ contractDetailInfo.tenantBody && contractDetailInfo.tenantBody.email ? contractDetailInfo.tenantBody.email : '--' }}</div>
                    </el-col>
                </el-row>
                <el-row
                    :gutter="24"
                    class="row"
                    >
                    <el-col :span="12">
                        <div>联系电话：{{ contractDetailInfo.tenantBody && contractDetailInfo.tenantBody.phonenumber ? contractDetailInfo.tenantBody.phonenumber : '--' }}</div>
                    </el-col>
                    <el-col :span="12">
                        <div >家庭住址：{{ contractDetailInfo.tenantBody && contractDetailInfo.tenantBody.homeAddress ? contractDetailInfo.tenantBody.homeAddress : '--' }}</div>
                    </el-col>
                </el-row>
            </div>
        </div>

         <el-divider></el-divider>

        <!-- 租赁场地信息区域 -->
        <div class="rental-venue-info">
            <div class="little-tip">租赁场地</div>
            <div class="rental-venue-content">
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
        </div>

         <!-- 固定租金信息区域 -->
        <div class="rent-info">
           <div class="little-tip">固定租金</div>
            <div class="list">
                <el-row
                    :gutter="24"
                    class="row"
                    >
                    <el-col :span="8">
                        <div>租金单价：{{ contractDetailInfo.tenantUnitPrice }}</div>
                    </el-col>
                    <el-col :span="8">
                        <div >日租金：{{ contractDetailInfo.dailyRent }}</div>
                    </el-col>
                    <el-col :span="8">
                        <div>月租金：{{ contractDetailInfo.monthRent }}</div>
                    </el-col>
                </el-row>
                 <el-row
                    :gutter="24"
                    class="row"
                    >
                    <el-col :span="8">
                        <div>管理费单价：{{ contractDetailInfo.manageUnitPrice }}</div>
                    </el-col>
                    <el-col :span="8">
                        <div >日管理费：{{ contractDetailInfo.dailyFee }}</div>
                    </el-col>
                    <el-col :span="8">
                        <div>月管理费：{{ contractDetailInfo.monthFee }}</div>
                    </el-col>
                </el-row>
            </div>
        </div>

        <el-divider></el-divider>

        <!-- 押付方式信息区域 -->
        <div class="deposit-info">
           <div class="little-tip">押付方式</div>
            <div class="deposit-info-content">
                <div>押：{{ contractDetailInfo.mortgageMonth }}</div>
                <div>付：{{ contractDetailInfo.mortgagePay }}</div>
            </div>
        </div>

        <el-row class="foot-btn">
            <el-button
                size="mini"
                @click="goback"
                >
                返回
            </el-button>
            <el-button 
                type="primary"
                size="mini"
                >
                打印
            </el-button>
        </el-row>
        
    </div>
</template>

<script>
import { contractPreview } from '../../../../api/asset/contract';
export default{
    name:"contarct-detail",
    props:{
        contractId:Number,
    },
    data(){
        return{
            contractDetailInfo:{},
            roomPreviewVoData:[]
        }
    },
    created(){
        this.$nextTick(() => {
        // DOM 现在已经更新
            this.getContractDetail();
        })
        
    },
    computed:{
        rentTime(){
            if(this.contractDetailInfo.startTime && this.contractDetailInfo.overTime){
                const startTime = this.contractDetailInfo.startTime.split(' ')[0];
                const overTime = this.contractDetailInfo.overTime.split(' ')[0];
                return startTime + '-'+overTime
            }
        }
    },
    methods:{
        //获取预览合同详情
        getContractDetail(){
            const queryData={
                contractId:Number(this.contractId)
            }
            contractPreview(queryData).then(res=>{
                console.log('预览接口调取成功',res);
                this.contractDetailInfo = res.data;
                this.roomPreviewVoData=[res.data.roomPreviewVo]
            }).catch(err=>{

            })
        },

        goback(){
            this.$router.push({
                path:'/assetManagement/contract'
            })
        }
    }
}
</script>

<style lang="scss" scoped>
.contract-info-container{
    font-size: 12px;
    color: #5f5f5f;

    .rental-venue-info{
        .rental-venue-content{
            margin-bottom: 20px;
        }
    }

    .deposit-info{
        margin-bottom: 20px;
        .deposit-info-content{
            display: flex;
            gap: 10px;
        }

    }

    .foot-btn{
        display: flex;
        justify-content: center;
    }
}
.little-tip{
    font-size: 14px;
    margin-bottom: 10px;
}
.row{
    box-sizing: border-box;
    margin-bottom: 10px;
    color: #848381;
}

</style>
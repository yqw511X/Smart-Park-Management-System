<template>
    <div class="order-detail-manage-container">
        <!-- 标题 -->
        <div class="title">
            工单详情
        </div>

        <div class="order-detail-container">
            <div class="order-detail-content">
            
                <!-- 维修进度 -->
                <div class="maintenance-progress">
                    <div class="title">
                        维修进度
                    </div>
                    <div class="progress">
                        <el-steps
                            align-center
                            size="mini"
                            :active="active">
                            <el-step 
                                size="mini" 
                                title="待分配" 
                                :description="allocateInfo"
                                icon="el-icon-warning"
                                >
                            </el-step>
                            <el-step 
                                size="mini" 
                                title="待处理" 
                                :description="pendingInfo"
                                icon="el-icon-warning"
                                v-if="pendingStatus"
                                >
                            </el-step>
                            <el-step 
                                size="mini" 
                                title="已完成" 
                                :description="finishInfo"
                                icon="el-icon-warning"
                                v-if="orderProgressData.finalStatus== '0' || this.orderProgressData.finalStatus== '1' || this.orderProgressData.finalStatus== '2' "
                                >
                            </el-step>
                            <el-step 
                                size="mini" 
                                title="已取消" 
                                :description="cancelInfo"
                                icon="el-icon-warning"
                                v-if="this.orderProgressData.finalStatus== '3'"
                                >
                            </el-step>
                        </el-steps>
                    </div>
                </div>

                <!-- 报修信息 -->
                <div class="repair-information">
                    <div class="title">
                        报修信息
                    </div>
                    <div class="list">
                        <el-row
                            :gutter="24"
                            class="row"
                            >
                            <el-col :span="8">
                                <div>租户：{{ orderInfoData.tenantName }}</div>
                            </el-col>
                            <el-col :span="8">
                                <div >维修单号：{{ orderInfoData.repairOrderNum }}</div>
                            </el-col>
                            <el-col :span="8">
                                <div>所属园区：{{ orderInfoData.parkName }}</div>
                            </el-col>
                        </el-row>
                        <el-row class="row" :gutter="24">
                            <el-col :span="8">
                                <div>联系人：{{ orderInfoData.contactName }}</div>
                            </el-col>
                            <el-col :span="8">
                                <div >报修时间：{{ orderInfoData.repairTime }}</div>
                            </el-col>
                            <el-col :span="8">
                                <div>所属楼宇：{{ orderInfoData.buildingName }}</div>
                            </el-col>
                        </el-row>
                        <el-row class="row" :gutter="24">
                            <el-col :span="8">
                                <div>联系电话：{{ orderInfoData.contactPhone }}</div>
                            </el-col>
                            <el-col :span="8">
                                <div v-if="orderInfoData.repairArea == '0'">报修区域：基础设施</div>
                                <div v-if="orderInfoData.repairArea == '1'">报修区域：水电设施</div>
                                <div v-if="orderInfoData.repairArea == '2'">报修区域：厨房与卫生间设施</div>
                                <div v-if="orderInfoData.repairArea == '3'">报修区域：供暖与制冷系统</div>
                                <div v-if="orderInfoData.repairArea == '4'">报修区域：公共区域</div>
                                <div v-if="orderInfoData.repairArea == '5'">报修区域：固有家电</div>
                                <div v-if="orderInfoData.repairArea == '6'">报修区域：安全设施</div>
                            </el-col>
                            <el-col :span="8">
                                <div>所属楼层：{{ orderInfoData.floorName }}</div>
                            </el-col>
                        </el-row>
                        <el-row class="row" :gutter="24">
                            <el-col :span="8">
                                <div>上门时间：{{ orderInfoData.visitTime }}</div>
                            </el-col>
                            <el-col :span="8">
                                <div >描述：{{ orderInfoData.remark }}</div>
                            </el-col>
                            <el-col :span="8">
                                <div>房间名称：{{ orderInfoData.roomName }}</div>
                            </el-col>
                        </el-row>
                        <el-row class="row" :gutter="24">
                            <el-col :span="8">
                                <div>维修申请照片</div>
                                <div v-if="orderInfoData.repairImage.length >0" style="margin-top: 5px;" v-for="(url, idx) in orderInfoData.repairImage" :key="idx">
                                    <img :src="url" style="width: 40%;" />
                                </div>
                                <span v-else>暂无照片</span>
                            </el-col>
                            <el-col :span="8">
                                <div ></div>
                            </el-col>
                            <el-col :span="8">
                                <div></div>
                            </el-col>
                        </el-row>
                    </div>
                </div>

                <!-- 维修信息 -->
                <div class="work-repair-information">
                    <div class="title">
                        维修信息
                    </div>
                    <div class="list">
                        <el-row
                            :gutter="24"
                            class="row"
                            >
                            <el-col :span="12">
                                <div>维修员：{{ orderInfoData.repairName }}</div>
                            </el-col>
                            <el-col :span="12">
                                <div >联系电话：{{ orderInfoData.phonenumber }}</div>
                            </el-col>
                        </el-row>
                        
                        <el-row
                            :gutter="24"
                            class="row"
                            >
                            <el-col :span="12">
                                <div>开始时间：{{ orderInfoData.createTime }}</div>
                            </el-col>
                            <el-col :span="12">
                                <div >结束时间：{{ orderInfoData.updateTime }}</div>
                            </el-col>
                        </el-row>
                    </div>
                </div>

                <!-- 维修日志 -->
                <!-- <div class="maintenance-log">
                    <div class="title">
                        维修日志
                    </div>
                    <div class="table">
                        <el-table
                            size="mini"
                            ref="multipleTable"
                            :data="orderLogData"
                            tooltip-effect="dark"
                            style="width: 100%"
                            @selection-change="handleSelectionChange">

                            <el-table-column
                                prop="status"
                                label="操作类型"
                                width="120">
                            </el-table-column>

                            <el-table-column
                                prop="human"
                                label="操作人"
                                >
                            </el-table-column>

                            <el-table-column
                                prop="repairName"
                                label="参与人员"
                                >
                            </el-table-column>

                            <el-table-column
                                prop="operationTime"
                                label="操作时间"
                                width="120">
                            </el-table-column>

                        </el-table>
                    </div>
                </div> -->
            </div>
        </div>
        
    </div>
   
</template>
<script>
import { orderInfo,orderProgress,orderLog } from '../../../api/order/order';
    export default{
        name:"orderDetail",
        data(){
            return{
                orderInfoData: [],//报修信息详情
                orderProgressData:[],//维修进度
                orderLogData:[],//维修日志
                currentOrderId:undefined,
                createTime:'',
                multipleSelection: [],
                active:undefined,
            } 
        },
        created(){
            this.initPage();
        },
        computed:{
            //待分配文字描述
            allocateInfo(){
                return this.orderProgressData.optionList[0].human +' '+ this.orderProgressData.optionList[0].operationTime
            },

            //待处理文字描述
            pendingInfo(){
                if(this.orderProgressData.finalStatus == '0'){
                    return ''
                }else if(this.orderProgressData.finalStatus == '1'){
                    return this.orderProgressData.optionList[1].human +' '+ this.orderProgressData.optionList[1].operationTime
                }else if(this.orderProgressData.finalStatus == '2'){
                    return this.orderProgressData.optionList[1].human +' '+ this.orderProgressData.optionList[1].operationTime
                }else if(this.orderProgressData.finalStatus == '3'){
                    if(this.orderProgressData.optionList.length == 2){
                        return ''
                    }else if(this.orderProgressData.optionList.length == 3){
                        return this.orderProgressData.optionList[1].human +' '+ this.orderProgressData.optionList[1].operationTime
                    }
                }else{
                    return ''
                }
            },

            //待处理显隐控制
            pendingStatus(){
                if(this.orderProgressData.finalStatus == '0'){
                    return true
                }else if(this.orderProgressData.finalStatus == '1'){
                    return true
                }else if(this.orderProgressData.finalStatus == '2'){
                    return true
                }else if(this.orderProgressData.finalStatus == '3'){
                    if(this.orderProgressData.optionList.length == 2){
                        return false
                    }else if(this.orderProgressData.optionList.length == 3){
                        return true
                    }
                }else{
                    return true
                }
            },


            //已完成文字描述
            finishInfo(){
                if(this.orderProgressData.finalStatus == '0'){
                    return ''
                }else if(this.orderProgressData.finalStatus == '1'){
                    return ''
                }else if(this.orderProgressData.finalStatus == '2'){
                    return this.orderProgressData.optionList[1].human +' '+ this.orderProgressData.optionList[1].operationTime
                }else if(this.orderProgressData.finalStatus == '3'){
                    return ''
                }else{
                    return ''
                }
            },

            //已取消文字描述
            cancelInfo(){
                if(this.orderProgressData.finalStatus == '0'){
                    return ''
                }else if(this.orderProgressData.finalStatus == '1'){
                    return ''
                }else if(this.orderProgressData.finalStatus == '2'){
                    return 
                }else if(this.orderProgressData.finalStatus == '3'){
                    if(this.orderProgressData.optionList.length == 2){
                        return this.orderProgressData.optionList[1].human +' '+ this.orderProgressData.optionList[1].operationTime
                    }else if(this.orderProgressData.optionList.length == 3){
                        return this.orderProgressData.optionList[2].human +' '+ this.orderProgressData.optionList[2].operationTime
                    }
                }else{
                    return ''
                }
            }

        },
        methods:{
            //初始化页面
            initPage(){
                this.createTime=this.$route.query.createTime;
                this.currentOrderId=this.$route.query.repairOrderId;
                this.$nextTick(() => {
                    this.getListOrderId();
                });
            },

            //获取工单详情（ID）
            getListOrderId(){
                //双重保障房间id
                if (!this.currentOrderId) {
                    this.currentOrderId = this.$route.query.repairOrderId;
                    if (!this.currentOrderId) {
                        return;
                    }
                }
                
                //获取报修信息详情
                orderInfo(this.currentOrderId).then(res=>{
                    console.log('报修详情',res);
                    this.orderInfoData = res.data;
                }).catch(()=>{

                })

                //获取维修进度
                orderProgress(this.currentOrderId).then(res=>{
                    console.log('维修进度',res);
                    this.orderProgressData = res.data;
                    
                    switch(res.data.finalStatus){
                        case "0":
                            this.active = 1;
                            break;
                        case "1":
                            this.active = 2;
                            break;
                        case "2":
                            this.active = 3;
                            break;
                        case "3":
                            this.active = 4;
                            break;
                        default: 
                            break;
                    }
                }).catch(()=>{

                })

                //获取维修日志
                orderLog(this.currentOrderId).then(res=>{
                    console.log('维修日志',res);
                    this.orderLogData = res.data;
                }).catch(()=>{

                })

            },

            toggleSelection(rows) {
                if (rows) {
                rows.forEach(row => {
                    this.$refs.multipleTable.toggleRowSelection(row);
                });
                } else {
                this.$refs.multipleTable.clearSelection();
                }
            },
            handleSelectionChange(val) {
                this.multipleSelection = val;
            }
        }
    }
</script>
<style lang="scss" scoped>
.order-detail-manage-container{
    box-sizing: border-box;

    //标题样式
    .title{
        padding:20px 15px;
        font-weight: bold;
        background-color: white;
    }

    .order-detail-container{
        padding: 20px;
        background-color: #f1f2f6;
        box-sizing: border-box;
        font-weight: normal;

        .order-detail-content{
            box-sizing: border-box;

            //维修进度样式
            .maintenance-progress{
                background-color: white;
                margin-bottom: 10px;
                padding: 10px;
                box-sizing: border-box;

                .title{
                    margin: 0;
                    margin-bottom: 20px;
                    box-sizing: border-box;
                    font-weight: normal;
                    padding-bottom: 10px;
                    font-size: 12px;
                    border-bottom: 1px solid rgba(128, 128, 128, 0.422);
                }
                .progress{
                    font-size: 12px;
                }
            }

            //报修信息样式
            .repair-information{
                background-color: white;
                padding: 10px;
                box-sizing: border-box;
                margin-bottom: 10px;

                .title{
                    margin: 0;
                    margin-bottom: 20px;
                    box-sizing: border-box;
                    padding-bottom: 10px;
                    font-weight: normal;
                    font-size: 12px;
                    border-bottom: 1px solid rgba(128, 128, 128, 0.422);
                }
                .list{
                    font-size: 12px;
                    box-sizing: border-box;
                    padding: 10px;

                    .row{
                        box-sizing: border-box;
                        margin-bottom: 10px;
                        color: #848381;
                    }
                }
            }

            //维修信息样式
            .work-repair-information{
                background-color: white;
                padding: 10px;
                box-sizing: border-box;
                margin-bottom: 10px;

                .title{
                    margin: 0;
                    margin-bottom: 20px;
                    box-sizing: border-box;
                    padding-bottom: 10px;
                    font-weight: normal;
                    font-size: 12px;
                    border-bottom: 1px solid rgba(128, 128, 128, 0.422);
                }
                .list{
                    font-size: 12px;
                    box-sizing: border-box;
                    padding: 10px;

                    .row{
                        box-sizing: border-box;
                        margin-bottom: 10px;
                        color: #848381;
                    }
                }
            }

             //维修日志样式
            .maintenance-log{
                background-color: white;
                padding: 10px;
                box-sizing: border-box;
                margin-bottom: 10px;

                .title{
                    margin: 0;
                    margin-bottom: 20px;
                    box-sizing: border-box;
                    padding-bottom: 10px;
                    font-weight: normal;
                    font-size: 12px;
                    border-bottom: 1px solid rgba(128, 128, 128, 0.422);
                }
            }
        }
    }
}
</style>


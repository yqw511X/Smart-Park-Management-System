<template>
    <div class="order-detail-manage-container">
        <!-- 标题 -->
        <div class="title">
            工单详情
        </div>

        <div class="order-detail-container">
            <div class="order-detail-content">
            
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
                                <div>报修人：{{ tableData.tenantName }}</div>
                            </el-col>
                            <el-col :span="8">
                                <div >维修单号：{{tableData.repairNum}}</div>
                            </el-col>
                            <el-col :span="8">
                                <div>状态：{{tableData.status}}</div>
                            </el-col>
                        </el-row>
                        <el-row class="row" :gutter="24">
                            <el-col :span="8">
                                <div>联系方式：{{tableData.contactPhone}}</div>
                            </el-col>
                            <el-col :span="8">
                                <div >公司：</div>
                            </el-col>
                            <el-col :span="8">
                                <div>园区：{{tableData.parkName}}</div>
                            </el-col>
                        </el-row>
                        <el-row class="row" :gutter="24">
                            <el-col :span="8">
                                <div>报修时间：{{tableData.repairTime}}</div>
                            </el-col>
                            <el-col :span="8">
                                <div >报修区域：{{tableData.repairArea}}</div>
                            </el-col>
                            <el-col :span="8">
                                <div></div>
                            </el-col>
                        </el-row>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
   
</template>
<script>
import {orderDetail} from './../../../api/repair/order.js'
    export default{
        name:"orderDetail",
        data(){
            return{
                tableData:{} ,
                multipleSelection: [],
                currentOrderId:'',
            } 
        },
        created(){
            this.initPage();
        },
        methods:{
            //初始化页面
            initPage(){
                //获取跳转id值
                this.currentOrderId = this.$route.query.repairOrderId;
                this.getOrderDetail();
            },

            //根据id查询工单详情
            getOrderDetail(){
                const repairOrderId = this.currentOrderId
                orderDetail(repairOrderId).then(res=>{
                    console.log('工单详情',res);
                    const areaMap = {
                        0: '基础设施',
                        1: '水电设施',
                        2: '厨房与卫生间设施',
                        3: '供暖与制冷系统',
                        4: '公共区域',
                        5: '固有家电',
                        6: '安全设施'
                    };

                    let newList = res.data;

                    newList.repairTime = newList.repairTime.replace('T', ' ');
                    newList.status = newList.repairArea = areaMap[newList.repairArea];;
                    

                    this.tableData = newList;
                    
                }).catch(err=>{

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
        font-weight: 18px;
        background-color: white;
    }

    .order-detail-container{
        padding: 20px;
        background-color: #f1f2f6;
        box-sizing: border-box;
        font-weight: normal;

        .order-detail-content{
            box-sizing: border-box;

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
        }
    }
}
</style>


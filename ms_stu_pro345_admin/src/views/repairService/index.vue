<template>
    <div class="my-repair-container">
        <!-- 标题 -->
        <div class="title">
            我的报修
        </div>

        <div class="my-repair-container">
            <div class="my-repair-content">
            
                <!-- 工单查询功能 -->
                <el-form 
                    :inline="true"
                    >
                    <el-form-item
                        class="el-form-item-gap"
                        size="mini" 
                        label="报修单号："  
                        >
                        <el-input 
                            placeholder="请输入报修单号"
                            v-model="repairNum"
                            >
                        </el-input>
                    </el-form-item>
                
                    <el-form-item 
                        class="el-form-item-gap"
                        label="工单状态："  
                        size="mini" 
                        >
                        <el-radio-group
                            v-model="status">
                            <el-radio-button label="0">待分配</el-radio-button>
                            <el-radio-button label="1">待处理</el-radio-button>
                            <el-radio-button label="2">已完成</el-radio-button>
                            <el-radio-button label="3">已取消</el-radio-button>
                        </el-radio-group>
                    </el-form-item>

                    <el-form-item 
                        class="el-form-item-gap"
                        size="mini">
                        <el-radio-group>
                            <el-button 
                                type="primary"
                                size="mini"
                                @click="searchOrder"
                                >
                                查询
                            </el-button>
                            <el-button
                                size="mini"
                                @click="resetForm"
                                >
                                重置
                            </el-button>
                        </el-radio-group>
                    </el-form-item>
                </el-form>

                <div class="add">
                    <el-button 
                        type="primary"
                        size="mini"
                        @click="toAdd()"
                        icon="el-icon-plus"
                        >
                        新建
                    </el-button>
                </div>

                <!-- 表格数据 -->
                <el-table
                    size="mini"
                    ref="multipleTable"
                    :data="myOrderData"
                    tooltip-effect="dark"
                    style="width: 100%"
                    @selection-change="handleSelectionChange"
                    v-loading="myordertableloading"
                    element-loading-text="数据加载中"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255,1)"
                    >

                    <el-table-column
                        prop="repairNum"
                        label="维修单号"
                        width="160">
                    </el-table-column>

                    <el-table-column
                        prop="repairArea"
                        label="报修区域"
                        width="130">
                        <template slot-scope="scope">
                            <div v-if="scope.row.repairArea == '0'">基础设施</div>
                            <div v-if="scope.row.repairArea == '1'">水电设施</div>
                            <div v-if="scope.row.repairArea == '2'">厨房与卫生间设施</div>
                            <div v-if="scope.row.repairArea == '3'">供暖与制冷系统</div>
                            <div v-if="scope.row.repairArea == '4'">公共区域</div>
                            <div v-if="scope.row.repairArea == '5'">固有家电</div>
                            <div v-if="scope.row.repairArea == '6'">安全设施</div>
                        </template>
                    </el-table-column>

                    <el-table-column
                        prop="contactName"
                        label="联系人"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="contactPhone"
                        label="联系电话"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="repairName"
                        label="维修工人"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="status"
                        label="状态"
                        >
                         <template slot-scope="scope">
                            <div v-if="scope.row.status == '0'">待分配</div>
                            <div v-if="scope.row.status == '1'">待处理</div>
                            <div v-if="scope.row.status == '2'">已完成</div>
                            <div v-if="scope.row.status == '3'">已取消</div>
                        </template>
                    </el-table-column>

                    <el-table-column
                        prop="repairTime"
                        label="报修时间"
                        >
                    </el-table-column>

                    <el-table-column
                        label="操作"
                        >
                        <template slot-scope="scope">
                            <el-button 
                                v-if="scope.row.status == '1'"
                                type="text"
                                size="mini"
                                @click="assignDialogVisible = true"
                                >
                                完成
                            </el-button>

                            <el-button 
                                v-if="scope.row.status == '0'"
                                type="text"
                                size="mini"
                                @click="toEditOrder(scope.row.repairOrderId)"
                            >
                                修改
                            </el-button>

                            <el-button 
                                v-if="scope.row.status == '0' ||scope.row.status == '1'"
                                type="text"
                                size="mini"
                                @click="toCancelOrder(scope.row.repairOrderId)"
                            >
                                取消
                            </el-button>

                            <el-button 
                                type="text"
                                size="mini"
                                @click="toDetail(scope.row.repairOrderId)"
                            >
                                详情
                            </el-button>
                        </template>
                    </el-table-column>
                </el-table>

                <!-- 分页区域 -->
                <div class="pagination">
                    <span></span>
                    <!-- 分页器 -->
                    <el-pagination
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange"
                        :current-page="pageNum"
                        :page-sizes="[5,10]"
                        :page-size="pageSize"
                        layout="total, sizes, prev, pager, next, jumper"
                        :total="total">
                    </el-pagination>
                </div>
            
            </div>
        </div>
        
    </div>
    
</template>
<script>
import { listMyOrder,myOrderCancel } from '../../api/tenant/order';
    export default{
        name:"order",
        components:{},
        data(){
            return{
                myordertableloading:true,
                myOrderData: [],
                multipleSelection: [],
                pageNum:1,
                pageSize:5,
                total:0,
                repairNum:'',
                status:'',
                assignDialogVisible:false,//指派员工显隐控制
                assignform:{
                    region:''
                }
            } 
        },
        created(){
            this.initPage();
        },
        methods:{
            initPage(){
                this.getMyOrderList();
            },

            //获取我的报修
            getMyOrderList(){
                this.myordertableloading = true;
                const queryData={
                    pageNum:this.pageNum,
                    pageSize:this.pageSize,
                    repairNum:this.repairNum,
                    status:this.status,
                }
                listMyOrder(queryData).then(res=>{
                    console.log(res);
                    this.myOrderData = res.rows;
                    this.total = res.total;
                    this.myordertableloading = false;

                }).catch(()=>{
                })
            },

            //查询工单
            searchOrder(){
                this.getMyOrderList();
            },

            //重置查询
            resetForm(){
                this.repairNum='',
                this.status='',
                this.getMyOrderList();
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
            },

            //每页条数变化
            handleSizeChange(val) {
                this.pageSize = val;
                this.getMyOrderList();
            },

            //当前页变化
            handleCurrentChange(val) {
                this.pageNum = val;
                this.getMyOrderList();
            },

            //路由跳转至详情界面
            toDetail(repairOrderId){

                this.$router.push({ 
                    path: "/repairService/repairDetail",
                    query:{
                        repairOrderId
                    }
                });
            },

            //路由跳转至新建界面
            toAdd(){
                this.$router.push({
                    path:"/repairService/addRepair",
                    query:{
                        status:'add'
                    }
                })
            },

            //修改工单
            toEditOrder(repairOrderId){
                console.log('信息',repairOrderId);
                
                this.$router.push({
                    path:'/repairService/addRepair',
                    query:{
                        status:'edit',
                        repairOrderId
                    }
                })
            },

            //取消订单
            toCancelOrder(repairOrderId){
                const data={
                    id:repairOrderId,
                    status:"3"
                }
                myOrderCancel(data).then(res=>{
                    console.log('取消订单',res);
                    if(res.code==200){
                        this.$message.success('操作成功');
                        this.getMyOrderList();
                    }else{
                        this.$message.error('错误，请联系管理员');
                    }
                }).catch(()=>{

                })
            }

        }
    }
</script>
<style lang="scss" scoped>
.my-repair-container{
    box-sizing: border-box;

    //标题样式
    .title{
        padding:20px 15px;
        font-weight: bold;
        background-color: white;
        font-size: 18px;
    }

    .my-repair-container{
        padding: 20px;
        background-color: #f1f2f6;
        box-sizing: border-box;
        font-weight: normal;

        .my-repair-content{
            padding: 20px;
            background-color: white;
            box-sizing: border-box;

            .add{
                margin-bottom: 20px;
            }

            .pagination{
                display: flex;
                justify-content: space-between;
            }
        }
        
        
    }
}

.el-form-item-gap{
    padding-right: 20px;
}
.center-select {
  display: flex;
  justify-content: center;
}

</style>
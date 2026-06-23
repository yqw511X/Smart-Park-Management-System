<template>
    <div class="order-manage-container">
        <!-- 标题 -->
        <div class="title">
            工单管理
        </div>

        <div class="order-container">
            <div class="order-content">
            
                <!-- 工单查询功能 -->
                <el-form 
                    :inline="true"
                    >
                    <!-- 报修单号 -->
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
                    
                    <!-- 工单状态 -->
                    <el-form-item 
                        class="el-form-item-gap"
                        label="工单状态："  
                        size="mini" >
                        <el-radio-group
                            v-model="status"
                            >
                            <el-radio-button 
                                label="0"
                                >
                                待分配
                            </el-radio-button>
                            <el-radio-button 
                                label="1"
                                >
                                待处理
                            </el-radio-button>
                            <el-radio-button 
                                label="2"
                                >
                                已完成
                            </el-radio-button>
                            <el-radio-button 
                                label="3"
                                >
                                已取消
                            </el-radio-button>
                        </el-radio-group>
                    </el-form-item>

                    <!-- 查询重置 -->
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

                <!-- 表格数据 -->
                <el-table
                    size="mini"
                    ref="multipleTable"
                    :data="orderData"
                    tooltip-effect="dark"
                    style="width: 100%"
                    @selection-change="handleSelectionChange"
                    v-loading="ordertableloading"
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
                        width="120">
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
                        prop="workerName"
                        label="维修工人"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="status"
                        label="状态"
                        >
                        <template slot-scope="scope">
                            <span v-if="scope.row.status==0">待分配</span>
                            <span v-else-if="scope.row.status==1">待处理</span>
                            <span v-else-if="scope.row.status==2">已完成</span>
                            <span v-else-if="scope.row.status==3">已取消</span>
                        </template>
                    </el-table-column>

                    <el-table-column
                        prop="createTime"
                        label="报修时间"
                        :formatter="dateFormatter"
                        >
                    </el-table-column>

                    <el-table-column
                        label="操作"
                        >
                        <template slot-scope="scope">
                            <el-button 
                                type="text"
                                size="mini"
                                @click="toDetail(scope.row)"
                            >
                                详情
                            </el-button>
                            <el-button 
                                type="text"
                                size="mini"
                                @click="getRepairList(scope.row)"
                                v-if="scope.row.status == 0 || scope.row.status == 1 "
                                >
                                指派
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

                <!-- 弹窗 -->
                <div class="assign-container">
                    <el-dialog 
                        title="指派维修员" 
                        :visible.sync="assignDialogVisible"
                        width="40%"
                        >
                        <el-form
                            :model="assignform">
                            <el-form-item
                                class="center-select"
                                label="维修员"
                                size="mini"
                            >
                                <el-select
                                    style="width: 300px;"
                                    v-model="assignform.repairId"
                                    placeholder="请选择维修工">
                                    <el-option
                                        v-for="item in repairManList"
                                        :key="item.repairManId"
                                        :label="item.repairManName"
                                        :value="item.repairManId"
                                        >
                                    </el-option>
                                </el-select>
                            </el-form-item>
                        </el-form>
                        <div slot="footer" class="dialog-footer">
                            <el-button
                                size="mini" 
                                @click="assignDialogVisible = false">
                                取 消
                            </el-button>
                            <el-button
                                size="mini"
                                type="primary" 
                                @click="toAssignOrder()">
                                确 定
                            </el-button>
                        </div>
                    </el-dialog>
                </div>
            
            </div>
        </div>
        
    </div>
    
</template>
<script>
import { listOrder,assignOrder,repairManName } from '../../api/order/order';
    export default{
        name:"order",
        components:{},
        data(){
            return{
                ordertableloading:true,
                orderData: [],
                pageNum:1,
                pageSize:5,
                repairNum:'',
                status:'',
                total:0,
                multipleSelection: [],
                repairManList:[],
                
                assignDialogVisible:false,//指派员工显隐控制
                assignform:{
                    repairId:'',
                    id:''
                }//指派提交表单
            } 
        },
        created(){
            this.getOrderList();
        },
        methods:{
            //获取工单列表详情
            getOrderList(){
                this.ordertableloading = true;
                const queryData = {
                    pageNum:this.pageNum, //当前页
                    pageSize: this.pageSize,
                    repairNum:this.repairNum,
                    status:this.status
                }
                listOrder(queryData).then(res=>{
                    this.orderData = res.rows;
                    this.total = res.total;
                    this.ordertableloading = false;
                }).catch(()=>{
                    console.log('接口错误');
                    
                })
            },

            //查询工单
            searchOrder(){
                this.getOrderList();
            },

            //重置查询
            resetForm(){
                this.repairNum='',
                this.status='',
                this.getOrderList();
            },

            //获取维修工列表
            getRepairList(row){
                this.assignform.id = row.repairOrderId;
                this.assignDialogVisible = true;
                repairManName().then(res=>{
                    this.repairManList = res;
                }).catch(()=>{

                })
            },

            //指派员工
            toAssignOrder(){
                const queryData = this.assignform;
                assignOrder(queryData).then(res=>{
                    console.log('指派员工',res);
                    if(res.status==200){
                        this.$message.success(res.message);
                        this.assignDialogVisible = false;
                        this.assignform.repairId ='';
                        this.getOrderList();
                    }else{
                        this.$message.error(res.message);
                    }
                }).catch(()=>{

                })
                
            },


           //每页条数变化
            handleSizeChange(val) {
                console.log(`每页 ${val} 条`);
                this.pageSize = val;
                this.getOrderList();
            },

            //当前页变化
            handleCurrentChange(val) {
                console.log(`当前页: ${val}`);
                this.pageNum = val;
                this.getOrderList();
            },

            dateFormatter(row, column, cellValue, index){
                if (!cellValue) return ''
                return cellValue.replace('T', ' ')
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

            //路由跳转
            toDetail(row){
                console.log('工单详情',row);
                
                this.$router.push({ 
                    path: "/workOrderManagement/orderDetail" ,
                    query:{
                        repairOrderId:row.repairOrderId,
                        createTime:row.createTime
                    }
                });
            }

        }
    }
</script>
<style lang="scss" scoped>
.order-manage-container{
    box-sizing: border-box;

    //标题样式
    .title{
        padding:20px 15px;
        font-weight: bold;
        background-color: white;
        font-size: 18px;
    }

    .order-container{
        padding: 20px;
        background-color: #f1f2f6;
        box-sizing: border-box;
        font-weight: normal;

        .order-content{
            padding: 20px;
            background-color: white;
            box-sizing: border-box;

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
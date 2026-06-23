<template>
    <div class="my-order-container">
        <!-- 标题 -->
        <div class="title">
            我的工单
        </div>

        <div class="my-order-container">
            <div class="my-order-content">
            
                <!-- 我的工单查询功能 -->
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
                        size="mini" >
                        <el-radio-group
                            v-model="status"
                            >
                            <el-radio-button label="3">待处理</el-radio-button>
                            <el-radio-button label="4">已完成</el-radio-button>
                        </el-radio-group>
                    </el-form-item>

                    <el-form-item 
                        class="el-form-item-gap"
                        size="mini">
                        <el-radio-group>
                            <el-button 
                                type="primary"
                                size="mini"
                                @click="searchOrder()"
                                >
                                查询
                            </el-button>
                            <el-button
                                size="mini"
                                @click="clearOrder()"
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
                    :data="repairOrderData"
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
                        width="160"
                        >
                       
                    </el-table-column>

                    <el-table-column
                        prop="repairArea"
                        label="报修区域"
                        width="160">
                        <template slot-scope="scope">
                            <div v-if="scope.row.status == 0">基础设施</div>
                            <div v-if="scope.row.status == 1">水电设施</div>
                            <div v-if="scope.row.status == 2">厨房与卫生间设施</div>
                            <div v-if="scope.row.status == 3">供暖与制冷系统</div>
                            <div v-if="scope.row.status == 4">公共区域</div>
                            <div v-if="scope.row.status == 5">固有家电</div>
                            <div v-if="scope.row.status == 6">安全设施</div>
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
                        prop="status"
                        label="状态"
                        >
                        <template slot-scope="scope">
                            <div v-if="scope.row.status == 0">待分配</div>
                            <div v-if="scope.row.status == 1">待处理</div>
                            <div v-if="scope.row.status == 2">已完成</div>
                            <div v-if="scope.row.status == 3">已取消</div>
                        </template>

                    </el-table-column>

                    <el-table-column
                        prop="createTime"
                        label="报修时间"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="address"
                        label="操作"
                        >
                        <template slot-scope="scope">
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
            </div>
        </div>
    </div>
</template>
<script>
import { repairManList } from '../../../api/repair/order';
    export default{
        name:"my-order",
        components:{},
        data(){
            return{
                ordertableloading:true,
                pageSize:5,
                pageNum:1,
                repairNum:'',
                status:'',

                repairOrderData: [],
                multipleSelection: [],

                assignDialogVisible:false,//指派员工显隐控制
                assignform:{
                    region:''
                }
            } 
        },
        created(){
            this.getRepairOrderList();
        },
        methods:{
            //维修工查询工单列表
            getRepairOrderList(){
                this.ordertableloading=true;
                const queryData = {
                    pageSize:this.pageSize,
                    pageNum:this.pageNum,
                    repairNum:this.repairNum,
                    status:this.status,
                }
                repairManList(queryData).then(res=>{
                    console.log('维修工工单',res);
                    this.repairOrderData = res.rows;
                    this.ordertableloading = false
                }).catch(()=>{

                })
            },

            //查询维修工工单
            searchOrder(){
                this.getRepairOrderList();
            },

              //查询维修工工单
            clearOrder(){
                this.repairNum='',
                this.status='',
                this.getRepairOrderList();
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
            toDetail(repairOrderId){
                this.$router.push({ 
                        path: "/repairMyOrder/myorderdetail", 
                        query:{
                            repairOrderId
                        }
                    });
            }

        }
    }
</script>
<style lang="scss" scoped>
.my-order-container{
    box-sizing: border-box;

    //标题样式
    .title{
        padding:20px 15px;
        font-weight: bold;
        background-color: white;
        font-size: 18px;
    }

    .my-order-container{
        padding: 20px;
        background-color: #f1f2f6;
        box-sizing: border-box;
        font-weight: normal;

        .my-order-content{
            padding: 20px;
            background-color: white;
            box-sizing: border-box;
        }
        
        .search{
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .sure{
            margin-bottom: 20px;
        }

        .assign-container{

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
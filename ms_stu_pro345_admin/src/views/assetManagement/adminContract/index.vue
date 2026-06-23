<template>
    <div class="room-container">
        <!-- 标题 -->
        <div class="title">
            合同管理
        </div>

        <!-- 表单区域 -->
        <div class="form-container">

            <!-- 合同查询条件 -->
            <div class="search-container">

                <!-- 合同名称 -->
                <div class="search">
                    <span class="tip">合同名称：</span>
                    <el-input 
                        class="input"
                        v-model="contractName" 
                        placeholder="请输入合同名称"
                        size="mini"
                        >
                    </el-input>
                </div>

                <!-- 合同编号 -->
                <div class="search">
                    <span class="tip">合同编号：</span>
                    <el-input 
                        class="input"
                        v-model="contractNum" 
                        placeholder="请输入合同编号"
                        size="mini"
                        >
                    </el-input>
                </div>

                <!-- 客户名称 -->
                <div class="search">
                    <span class="tip">客户名称：</span>
                    <el-input 
                        class="input"
                        v-model="nickName" 
                        placeholder="请输入客户名称"
                        size="mini"
                        >
                    </el-input>
                </div>

                <!-- 合同状态 -->
                <div class="search">
                    <span class="tip">合同状态：</span>
                    <el-select 
                        v-model="status" 
                        placeholder="请选择合同状态"
                        size="mini"
                        >
                        <el-option
                            v-for="item in options"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                        </el-option>
                    </el-select>
                </div>                
            </div>

            <!-- 查询和重置按钮 -->
            <div class="search-reset-btn">
                <el-button
                    type="primary"
                    @click="handleSearch()"
                    size="mini"
                    >
                    查询
                </el-button>
                <el-button
                    @click="handleReset()"
                    size="mini"
                    >
                    重置
                </el-button>
            </div>
            
            <!-- 新建按钮 -->
            <div class="btn-add">
                <el-button
                    type="primary"
                    icon="el-icon-plus"
                    @click="toEditContract()"
                    size="mini"
                    >
                    新建
                </el-button>
                <el-button
                    type="danger"
                    icon="el-icon-plus"
                    @click="deleteContracts()"
                    v-if="this.multipleSelection.length >0"
                    size="mini"
                    >
                    删除
                </el-button>
            </div>
            <!-- 表格区域 -->
            <div class="form-content">

                <!-- 数据表格 -->
                <el-table
                    class="table"
                    ref="multipleTable"
                    :data="contractData"
                    tooltip-effect="dark"
                    style="width: 100%"
                    v-loading="contractTableloading"
                    element-loading-text="数据加载中"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255,1)"
                    @selection-change="handleSelectionChange"
                    size="mini"
                >
                    <el-table-column
                        type="selection"
                        :selectable="checkSelectable"
                        width="55"
                        >
                    </el-table-column>

                    <!-- 合同名称 -->
                    <el-table-column
                        prop="contractName"
                        label="合同名称"
                        show-overflow-tooltip>
                    </el-table-column>

                    <!-- 合同状态 -->
                    <el-table-column
                        prop="status"
                        label="合同状态"
                        width="120">
                         <template slot-scope="scope">
                            <el-button 
                                v-if="scope.row.status==0"
                                type="warning" 
                                plain 
                                disabled
                                size="mini"
                                >
                                待签订
                            </el-button>

                            <el-button
                                v-if="scope.row.status==1" 
                                type="success" 
                                plain 
                                disabled
                                size="mini"
                                >
                                执行中
                            </el-button>

                            <el-button 
                                v-if="scope.row.status==2"
                                type="info" 
                                plain 
                                disabled
                                size="mini"
                                >
                                已完成
                            </el-button>
                        </template>   
                    </el-table-column>

                    <!-- 合同编号 -->
                    <el-table-column
                        prop="contractNum"
                        label="合同编号"
                        width="120">
                    </el-table-column>

                    <!-- 签订日期 -->
                     <el-table-column
                        prop="dateSign"
                        label="签订日期"
                        show-overflow-tooltip
                        :formatter="formatDate"
                        >
                    </el-table-column>

                    <!-- 租赁开始期限 -->
                    <el-table-column
                        prop="startTime"
                        label="租赁开始期限"
                        show-overflow-tooltip
                        :formatter="formatDate"
                        >
                    </el-table-column>

                    <!-- 租赁结束期限 -->
                    <el-table-column
                        prop="overTime"
                        label="租赁结束期限"
                        show-overflow-tooltip
                        :formatter="formatDate"
                        >
                    </el-table-column>  

                    <!-- 联系电话 -->
                    <el-table-column
                        prop="phonenumber"
                        label="联系电话"
                        width="120"
                        >
                    </el-table-column>

                    <!-- 操作 -->
                    <el-table-column
                        prop="address"
                        label="操作"
                        show-overflow-tooltip
                    >
                        <template slot-scope="scope">

                            <!-- 执行中按钮 -->
                            <el-button
                                size="mini"
                                type="text"
                                v-if="scope.row.status == 1"
                                @click="handleChange(scope.$index, scope.row)"
                                >
                                变更
                            </el-button>

                            <el-button
                                size="mini"
                                type="text"
                                v-if="scope.row.status == 1"
                                @click="handleLease(scope.$index, scope.row)"
                                >
                                退租
                            </el-button>

                            <!-- 已终止按钮 -->
                            <el-button
                                size="mini"
                                type="text"
                                @click="handlePreview(scope.$index, scope.row)"
                                v-if="scope.row.status == 2"
                                >
                                预览
                            </el-button>

                            <!-- 待签订按钮 -->
                            <el-button
                                size="mini"
                                type="text"
                                v-if="scope.row.status == 0"
                                @click="handleEdit(scope.$index, scope.row)"
                                >
                                编辑
                            </el-button>

                            <el-button
                                size="mini"
                                type="text"
                                v-if="scope.row.status == 0"
                                @click="handleSign(scope.$index, scope.row)"
                                >
                                签订
                            </el-button>

                            <el-button
                                size="mini"
                                type="text"
                                v-if="scope.row.status == 0"
                                @click="handleDelete(scope.$index, scope.row)"
                                >
                                删除
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

                <!-- 右侧抽屉 -->
                  <!-- <el-drawer
                    title="我是标题"
                    :visible.sync="drawer"
                    :direction="direction"
                    :before-close="handleClose">
                    <span>我来啦!</span>
                </el-drawer> -->

                
             </div>
        </div>
    </div>
</template>
<script>
import { deleteContract, listContract,signContract } from '../../../api/asset/contract';
    export default{
        name:"room",
        data(){

            return{
                contractTableloading:true,
                contractData: [],//合同表格数据
                pageNum:1, //当前页
                pageSize: 5,
                contractName:'',
                contractNum:'',
                nickName:'',
                status:'',

                total: undefined,

                options: [
                    {
                        value: 0,
                        label: '待签订'
                    },
                    {
                        value: 1,
                        label: '执行中'
                    },
                    {
                        value: 2,
                        label: '已完成'
                    },
                ],
                dialogTableVisible: false,

                
                drawer: false,
                direction: 'rtl',//右侧抽屉


                dialogFormVisible: false,//表单弹窗显示控制

                formLabelWidth: '120px',
                multipleSelection: []
        
            }
        },
        created(){
            this.getContractList();
        },
        methods:{
            //获取合同列表(分页)
            getContractList(){
                this.contractTableloading = true;
                const query = {
                    pageNum:this.pageNum,
                    pageSize: this.pageSize,
                    contractName:this.contractName,
                    contractNum:this.contractNum,
                    nickName:this.nickName,
                    status:this.status,
                }
                listContract(query).then(res=>{
                    console.log('获取合同列表',res);
                    this.total = res.total;
                    this.contractData = res.list;
                    this.contractTableloading = false;                
                }).catch(()=>{

                })
            },

            //跳转合同编辑页面（新建）
            toEditContract(){
                this.$router.push({
                    path:'/assetManagement/contractedit',
                    query:{
                        status:'add'
                    }
                })
            },

            //跳转合同预览界面
            handlePreview(index, row){
                console.log(row);
                
                this.$router.push({
                    path:'/assetManagement/contractdetail',
                    query:{
                        contractId:row.contractId,
                    }
                })
            },

            //表格记录选择
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },

            //表格记录编辑（编辑）
            handleEdit(index, row) {
                this.$router.push({
                    path:'/assetManagement/contractedit',
                    query:{
                        status:'edit',
                        contractId:row.contractId,
                    }
                })
            },

            // //表格记录编辑（变更）
            handleChange(index, row) {
                this.$router.push({
                    path:'/assetManagement/contractedit',
                    query:{
                        status:'change',
                        contractId:row.contractId,
                    }
                })
            },

            //合同签订
            handleSign(index,row){
                this.$confirm(`确认签订已选的合同信息？`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    center: true
                }).then(() => {
                    const queryData={
                        contractId:row.contractId
                    }
                    signContract(queryData).then(res=>{
                        console.log('签订合同响应',res);
                        if(res.status==200){
                            this.$message.success(res.message);
                            this.getContractList();
                        }else{
                            this.$message.error(res.message);
                        }
                    }).catch(()=>{

                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消签订'
                    });
                });
               
            },

            //去往退租编辑界面
            handleLease(index,row){
                console.log('当前退租合同信息',row);
                
                this.$router.push({
                    path:'/assetManagement/lease',
                    query:{
                        contractId:row.contractId,
                    }
                })
            },

            //表格格式化
            formatDate(row, column, cellValue){
                if (!cellValue) return '--'
                // 按 T 分割，取第一部分
                return cellValue.split('T')[0]
            },

            //表格记录删除
            handleDelete(index, row) {
                console.log(index, row);
            },

            

            handle(scope){
                console.log(scope);
                
            },

            //查询合同信息
            handleSearch(){
                this.getContractList();
            },
            
            //重置查询表单信息
            handleReset(){
                this.contractName = '';
                this.contractNum = '';
                this.nickName = '';
                this.status= '';
                this.getContractList();
            },

            //变换每页条数
            handleSizeChange(val) {
                console.log(`每页 ${val} 条`);
                this.pageSize = val;
                this.getContractList();
            },

            //变换当前页 
            handleCurrentChange(val) {
                console.log(`当前页: ${val}`);
                this.pageNum = val;
                this.getContractList();
            },

            //多选条件限制
            checkSelectable(row) {
                return row.status == '0';
            },

            handleSelectionChange(val) {
                this.multipleSelection = val;
            },

            //删除合同
            toDeleteContract(contractIds){
                deleteContract(contractIds).then(res => {
                    console.log(res);
                    if(res.status == 200){
                        this.$message({
                            type: 'success',
                            message: res.message,
                        });
                        this.getContractList();
                    }else{
                        this.$message({
                            type: 'danger',
                            message: res.message,
                        })
                    }
                }).catch(() => {
                    
                })
            },
            
            //删除单个合同
            handleDelete(index,row){
                console.log(row);
                
                this.$confirm(`确认删除当前合同信息？`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    center: true
                }).then(() => {
                    const contractId = row.contractId;
                    this.toDeleteContract(contractId);
                    
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },

            //删除多个合同
            deleteContracts(){
                this.$confirm(`确认删除已选的${this.multipleSelection.length}条合同信息？`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    center: true
                }).then(() => {
                    const contractIds = this.multipleSelection.map(({ contractId }) => contractId);
                    this.toDeleteContract(contractIds);
                    
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            }
        },
    }
</script>

<style lang="scss" scoped>

.room-container{
    box-sizing: border-box;
    

    // 大字标题样式
    .title{
        font-size: 18px;
        font-weight: bold;
        background-color: white;
        padding:20px 15px;
    }

    // 表单区域样式
    .form-container{
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        gap: 15px;
        margin: 20px;
        padding: 20px;
        background-color: white;

        // 查找租户样式
        .search-container{
            display: flex;
            align-items: center;
            gap:15px;
            
            .search{
                .tip{
                    font-size: 12px;
                    font-weight: normal;
                }

                .input{
                    width: 200px;
                }
            }
            
            
        }

        //查询重置按钮样式
        .search-reset-btn{
            display: flex;
            justify-content: center;
        }

        // 表格区域样式
        .form-content{
            display: flex;
            flex-direction: column;
            gap: 10px;

            .table{

            }

            .pagination{
                display: flex;
                justify-content: space-between;
            }

            .record{
                float: right;
               
            }
        }
    }
}
</style>
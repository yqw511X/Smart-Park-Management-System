<template>
    <div class="lease-application-approval-container">
        <!-- 标题 -->
        <div class="title">
            租赁申请审批
        </div>

        <div class="application-approval-container">
            <div class="application-approval-content">

                <!-- 搜索区域 -->
                <el-form 
                    :inline="true"
                    >
                    <!-- 申请人 -->
                    <el-form-item
                        class="el-form-item-gap"
                        size="mini" 
                        label="申请人："  
                        >
                        <el-input 
                            placeholder="请输入申请人"
                            v-model="name"
                            >
                        </el-input>
                    </el-form-item>

                    <!-- 联系电话 -->
                    <el-form-item
                        class="el-form-item-gap"
                        size="mini" 
                        label="联系电话："  
                        >
                        <el-input 
                            placeholder="请输入联系电话"
                            v-model="phone"
                            >
                        </el-input>
                    </el-form-item>
                
                    <el-form-item 
                        class="el-form-item-gap"
                        label="审批状态："  
                        size="mini" >
                        <el-radio-group
                            v-model="status"
                            >
                            <el-radio-button label="0">待审批</el-radio-button>
                            <el-radio-button label="1">审批通过</el-radio-button>
                            <el-radio-button label="2">已拒绝</el-radio-button>
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
                                @click="searchRenter()"
                                >
                                查询
                            </el-button>
                            <el-button
                                size="mini"
                                @click="clearRenter()"
                                >
                                重置
                            </el-button>
                        </el-radio-group>
                    </el-form-item>
                </el-form>

                <!-- 表格区域 -->
                <el-table
                    size="mini"
                    ref="multipleTable"
                    :data="applyData"
                    tooltip-effect="dark"
                    style="width: 100%"
                    @selection-change="handleSelectionChange"
                    v-loading="appliytableloading"
                    element-loading-text="数据加载中"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255,1)"
                    >
                    <el-table-column
                        prop="tenantName"
                        label="租户"
                        width="90">
                    </el-table-column>

                    <el-table-column
                        prop="parkName"
                        label="申请园区"
                        width="85">
                    </el-table-column>

                    <el-table-column
                        prop="buildingName"
                        label="申请楼宇"
                        width="85">
                    </el-table-column>

                    <el-table-column
                        prop="floorName"
                        label="申请楼层"
                        width="85"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="roomNumber"
                        label="申请房间"
                        width="85"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="status"
                        label="租赁状态"
                        width="85"
                        >
                        <template slot-scope="scope">
                            <span v-if="scope.row.status == 1">
                                已上架
                            </span>
                            <span v-if="scope.row.status == 0">
                                未上架
                            </span>
                        </template>
                    </el-table-column>

                    <el-table-column
                        prop="phone"
                        label="联系电话"
                        width="120"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="startTime"
                        label="申请租赁开始时间"
                        width="140"
                        :formatter="formatDate"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="endTime"
                        label="申请租赁结束时间"
                        width="140"
                        :formatter="formatDate"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="approvalStatus"
                        label="审批状态"
                        width="80"
                        >
                         <template slot-scope="scope">
                            <span v-if="scope.row.approvalStatus == 0">
                                待审批
                            </span>
                            <span v-if="scope.row.approvalStatus == 1">
                                审批通过
                            </span>
                            <span v-if="scope.row.approvalStatus == 2">
                                已拒绝
                            </span>
                            <span v-if="scope.row.approvalStatus == 3">
                                已取消
                            </span>
                        </template>
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
                                房屋详情
                            </el-button>

                            <el-button 
                                type="text"
                                size="mini"
                                @click="toApply(scope.row.id)"
                                >
                                审批
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
                <div class="approval-dialog-container">
                    <el-dialog 
                        title="审批" 
                        :visible.sync="approvalDialogVisible"
                        width="30%"
                        >
                        <el-form
                            label-position="right"
                            :model="applyForm"
                            :rule="applyRule"
                            ref="approveForm"
                            >
                            <el-form-item
                                class="center-select"
                                label="审批结果："
                                size="mini"
                                prop="applyStatus"
                            >
                                <el-select
                                    style="width: 300px;"
                                    v-model="applyForm.applyStatus"
                                    placeholder="请选择">
                                    <el-option label="待审批" value="0"></el-option>
                                    <el-option label="审批通过" value="1"></el-option>
                                    <el-option label="已拒绝" value="2"></el-option>
                                    <el-option label="已取消" value="3"></el-option>
                                </el-select>
                            </el-form-item>

                            <el-form-item
                                class="center-select"
                                label="审批意见："
                                size="mini"
                                prop="applymark"
                            >
                                <el-input
                                    v-model="applyForm.applymark"
                                    type="textarea"
                                    :rows="6"
                                    placeholder="请输入内容"
                                    >
                                </el-input>
                            </el-form-item>
                        </el-form>
                        <div slot="footer" class="dialog-footer">
                            <el-button
                                size="mini" 
                                @click="approvalDialogVisible = false">
                                取 消
                            </el-button>
                            <el-button
                                size="mini"
                                type="primary" 
                                @click="sendApply()">
                                确 定
                            </el-button>
                        </div>
                    </el-dialog>
                </div>

                <!-- 右侧抽屉 -->
                <el-drawer
                    :title="drawerTitle"
                    :visible.sync="drawer"
                    direction="rtl"
                    size="50%">
                    <el-table 
                        :data="recordData">
                        <!-- 租户状态 -->
                        <el-table-column 
                            property="status" 
                            label="租户状态" 
                            width="100"
                            >
                            <template slot-scope="scope">
                                <el-button
                                    v-if="scope.row.status == 1"  
                                    type="success" 
                                    plain
                                    >
                                    在租
                                </el-button>
                                <el-button 
                                    v-else
                                    type="info" 
                                    plain
                                    >
                                    退租
                                </el-button>
                            </template>
                        </el-table-column>

                        <!-- 租户名称 -->
                        <el-table-column 
                            property="tenantName" 
                            label="租户名称" 
                            width="100"
                            >
                        </el-table-column>

                        <!-- 入住时间 -->
                        <el-table-column 
                            property="time" 
                            label="入住时间" 
                            width="150"
                            >
                            
                        </el-table-column>

                        <!-- 身份证 -->
                        <el-table-column 
                            property="idNum" 
                            label="身份证" 
                            width="165"
                            >
                        </el-table-column>

                        <!-- 邮箱 -->
                        <el-table-column 
                            property="email" 
                            label="邮箱" 
                            width="150"
                            >
                        </el-table-column>
                        
                        <!-- 联系电话 -->
                        <el-table-column 
                            property="phonenumber" 
                            label="联系电话" 
                            width="150"
                            >
                        </el-table-column>

                        <!-- 家庭住址 -->
                        <el-table-column 
                            property="address" 
                            label="家庭住址" 
                            width="200"
                            >
                        </el-table-column>
                    </el-table>
                </el-drawer>
                
            </div>
        </div>
        
    </div>
   
</template>
<script>
import { listApplication,approveRenterPass } from '../../api/apply/apply';
import {roomRecord} from './../../api/park/room.js'
    export default{
        name:"orderDetail",
        data(){
            return{
                appliytableloading:true,
                applyData: [],
                pageNum:1,
                pageSize:5,
                name:'',
                phone:'',
                status:'',
                total:0,
                approvalDialogVisible:false,

                applyForm:{
                    applyStatus:'',//审批状态
                    applymark:'',//审批意见
                    applyId:'',//审批单号
                },
                applyRule: {
                    applyStatus: [
                    { required: true, message: '请选择审批结果', trigger: 'change' }
                    ],
                    applymark: [
                    { required: true, message: '请输入审批意见', trigger: 'blur' },
                    { min: 2, max: 200, message: '长度在 2 到 200 个字符', trigger: 'blur' }
                    ]
                },
                drawer: false,//右侧抽屉
                recordData:[],
                drawerRoomName:'',
                drawerBuildingName:'',
                drawerFloorName:'',
            } 
        },
        created(){
            this.applyList();
        },
        computed:{
            //抽屉标题
            drawerTitle(){
                return this.drawerRoomName + '  ' + this.drawerBuildingName + '  ' + this.drawerFloorName;
            },

            //抽屉(入住时间与退租时间)
            timeTenantTime(row){
                return row.time + '-' + row.tenantTime;
            },
        },

        methods:{
            //条件查询审批数据
            searchRenter(){
                console.log(this.status);
                this.applyList();
            },

            //清除搜索框
            clearRenter(){
                this.status='';
                this.applyList();
            },

            //查询租赁申请审批数据
            applyList(){
                this.appliytableloading=true;
                const queryData ={
                    pageNum:this.pageNum,
                    pageSize:this.pageSize,
                    name:this.name,
                    phone:this.phone,
                    status:this.status
                }
                listApplication(queryData).then(res=>{
                    console.log('数据审批',res);
                    this.applyData = res.rows;
                    this.total = res.total;
                    this.appliytableloading=false;
                }).catch(()=>{

                })
            },

            //审批处理函数
            ToapproveRenterPass(){
                const queryData={
                    id:this.applyForm.applyId,
                    status:this.applyForm.applyStatus,
                    remark:this.applyForm.applymark
                }
                approveRenterPass(queryData).then(res=>{
                    console.log('审批提交信息',res);
                    if(res.status === 200){
                        this.$message.success('审批通过');
                        this.approvalDialogVisible = false;
                    }else{
                        this.$message.error(res.msg);
                    }
                }).catch(()=>{

                })
            },

            //发送审批请求
            sendApply(){
                this.$refs.approveForm.validate((valid) => {
                    if (valid) {
                    // 验证通过，执行提交逻辑
                        this.ToapproveRenterPass();
                    } else {
                        this.$message.error('请完整填写表单')
                        return false
                    }
                })
                
            },

            //查看房屋详情
            viewDetail(row){
                console.log(row);
                this.drawerRoomName = row.roomName;
                this.drawerBuildingName = row.buildingName;
                this.drawerFloorName = row.floorName;
                this.drawer = true;
                const roomId = row.roomId;
                roomRecord(roomId).then(res=>{
                    this.recordData = res.data;
                }).catch(()=>{

                })
            },

            //查看房屋详情
            toDetail(row){
                console.log(row);
                
                this.drawer = true;
                this.drawerRoomName = row.roomNumber;
                this.drawerBuildingName = row.buildingName;
                this.drawerFloorName = row.floorName;
                roomRecord(row.id).then(res=>{
                    console.log('租赁记录',res);
                    this.recordData = res.data;
                }).catch(()=>{

                })
            },

            //审批数据
            toApply(id){
                this.approvalDialogVisible = true;
                this.applyForm.applyId = id;
            },

            //表格格式化数据 
            formatDate(row, column, cellValue, index) {
                if (!cellValue) return '';
                // 假设原始格式是 "2026-03-01 00:00:00"
                return cellValue.slice(0, 10);
            },

            //每页条数变化
            handleSizeChange(val) {
                console.log(`每页 ${val} 条`);
                this.pageSize = val;
                this.applyList();
            },

            //当前页变化
            handleCurrentChange(val) {
                console.log(`当前页: ${val}`);
                this.pageNum = val;
                this.applyList();
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
.lease-application-approval-container{
    box-sizing: border-box;

    //标题样式
    .title{
        padding:20px 15px;
        font-weight: bold;
        background-color: white;
    }

    .application-approval-container{
        padding: 20px;
        background-color: #f1f2f6;
        box-sizing: border-box;
        font-weight: normal;

        .application-approval-content{
            box-sizing: border-box;
            background-color: white;
            padding: 20px;

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

.item-font-size{
    font-size: 12px;
    font-weight: normal;
}
</style>


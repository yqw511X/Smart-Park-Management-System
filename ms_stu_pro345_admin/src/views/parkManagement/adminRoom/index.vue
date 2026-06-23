<template>
    <div class="room-container">
        <!-- 标题 -->
        <div class="title">
            房间管理
        </div>

        <!-- 表单区域 -->
        <div class="form-container">

            <!-- 房间查询 -->
            <div class="search-container">

                <!-- 房间名称 -->
                <div class="search">
                    <span class="tip">房间名称：</span>
                    <el-input 
                        class="input"
                        v-model="roomName" 
                        placeholder="请输入房间名称"
                        size="mini"
                        >
                    </el-input>
                </div>

                <!-- 所属楼宇 -->
                <div class="search">
                    <span class="tip">所属楼宇：</span>
                    <el-input 
                        class="input"
                        v-model="buildingName" 
                        placeholder="请输入所属楼宇名称"
                        size="mini"
                        >
                    </el-input>
                </div>

                <!-- 租赁状态 -->
                <div class="search">
                    <span class="tip">租赁状态：</span>
                    <el-radio-group
                        v-model="tenantStatus"
                        size="mini" >
                        <el-radio-button label="1">在租</el-radio-button>
                        <el-radio-button label="0">未租</el-radio-button>
                    </el-radio-group>
                </div>
                
                <!-- 查询与重置 -->
                <div class="button">
                     <el-button 
                        size="mini" 
                        type="primary"
                        @click="getRoomList()"
                        >
                        查询
                    </el-button>
                    <el-button 
                        size="mini"
                        @click="formReset()"
                        >
                        重置
                    </el-button>
                </div>
            </div>

            <!-- 新建按钮 -->
            <div class="btn-add">
                <el-button
                    type="primary"
                    icon="el-icon-plus"
                    @click="toRoomDetail('add')"
                    size="mini"
                    >
                    新建
                </el-button>

                <el-button
                    v-if="multipleRoomSelection.length != 0"
                    type="danger"
                    icon="el-icon-plus"
                    @click="deleteRooms()"
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
                    :data="roomData"
                    tooltip-effect="dark"
                    style="width: 100%"
                    @selection-change="handleSelectionChange"
                    size="mini"
                    v-loading="roomtableloading"
                    element-loading-text="数据加载中"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255,1)"
                >
                    <!-- 选择 -->
                    <el-table-column
                        type="selection"
                        width="55">
                    </el-table-column>

                    <!-- 所属园区 -->
                    <el-table-column
                        prop="parkName"
                        label="所属园区"
                        width="100">
                    </el-table-column>

                    <!-- 房间名称 -->
                    <el-table-column
                        prop="roomName"
                        label="房间名称"
                        width="100">
                    </el-table-column>

                    <!-- 所属楼宇 -->
                    <el-table-column
                        prop="buildingName"
                        label="所属楼宇"
                        width="100">
                    </el-table-column>

                    <!-- 所属楼层 -->
                     <el-table-column
                        prop="floorName"
                        label="所属楼层"
                        width="100">
                    </el-table-column>

                    <!-- 面积（平方米） -->
                    <el-table-column
                        prop="area"
                        label="面积（平方米）"
                        show-overflow-tooltip
                        >
                    </el-table-column>

                    <!-- 租赁状态 -->
                    <el-table-column
                        prop="tenantStatus"
                        label="租户状态"
                        width="100"
                    >
                        <template slot-scope="scope">
                            <el-button 
                                v-if="scope.row.tenantStatus == 0" 
                                type="info" 
                                plain 
                                disabled
                                size="mini"
                                >
                                未租
                            </el-button>
                            <el-button 
                                v-else
                                type="success" 
                                plain 
                                disabled
                                size="mini"
                                >
                                在租
                            </el-button>
                        </template>   
                    </el-table-column>

                    <!-- 租金 -->
                    <el-table-column
                        prop="tenantMoney"
                        label="租金（元）"
                        width="120">
                    </el-table-column>

                    <!-- 租金类型 -->
                    <el-table-column
                        prop="tenantMoneyType"
                        label="租金类型"
                        :formatter="formatRentType"
                        width="80">
                    </el-table-column>

                    <!-- 上线时间 -->
                    <el-table-column
                        prop="createTime"
                        label="上线时间"
                        width="160">
                    </el-table-column>

                    <!-- 是否上架 -->
                    <el-table-column
                        prop="status"
                        label="是否上架"
                        width="80">
                        <template slot-scope="scope">
                            <el-switch
                                v-model="scope.row.status"
                                @change="toRoomStatus(scope.row)"
                                >

                            </el-switch>
                        </template>
                        
                    </el-table-column>

                    <!-- 操作 -->
                    <el-table-column
                        prop="address"
                        label="操作"
                        fixed="right"
                        width="120"
                    >
                        <template slot-scope="scope">

                            <!-- 编辑按钮 -->
                            <el-button
                                size="mini"
                                type="text"
                                @click="toRoomDetail('edit',scope.row)"
                                >
                                编辑
                            </el-button>

                            <!-- 删除按钮 -->
                            <el-button
                                size="mini"
                                type="text"
                                @click="deleteOnlyRoom(scope.row)"
                                >
                                删除
                            </el-button>

                            <!-- 记录按钮 -->
                            <el-button
                                size="mini"
                                type="text"
                                @click="viewRecord(scope.row)"
                                >
                                记录
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
                        :total="roomTotal">
                    </el-pagination>
                </div>

                <!-- 右侧抽屉 -->
                <el-drawer
                    :title="drawerTitle"
                    :visible.sync="drawer"
                    direction="rtl"
                    size="50%">
                    <el-table 
                        :data="recordData"
                        >
                        <!-- 租户状态 -->
                        <el-table-column 
                            prop="status" 
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
                            prop="tenantName" 
                            label="租户名称" 
                            width="100"
                            >
                        </el-table-column>

                        <!-- 入住时间 -->
                        <el-table-column 
                            prop="time" 
                            label="入住时间" 
                            width="160"
                            >
                        </el-table-column>

                        <!-- 身份证 -->
                        <el-table-column 
                            prop="idNum" 
                            label="身份证" 
                            width="165"
                            >
                        </el-table-column>

                        <!-- 邮箱 -->
                        <el-table-column 
                            prop="email" 
                            label="邮箱" 
                            width="150"
                            >
                        </el-table-column>
                        
                        <!-- 联系电话 -->
                        <el-table-column 
                            prop="phonenumber" 
                            label="联系电话" 
                            width="150"
                            >
                        </el-table-column>

                        <!-- 家庭住址 -->
                        <el-table-column 
                            prop="address" 
                            label="家庭住址" 
                            width="150"
                            >
                        </el-table-column>
                    </el-table>
                </el-drawer>

                
             </div>
        </div>
    </div>
</template>
<script>
import { listRoom, deleteRoom,roomStatus,roomRecord } from '../../../api/park/room';
    export default{
        dicts: ['rent_type'],
        name:"room",
        data(){

            return{
                roomData:[],//我的房间数据
                roomtableloading:true,

                //查询房间列表所需参数
                pageNum:1,  //当前页
                pageSize: 5, //每页条数
                buildingName:'', //楼宇名称
                roomName:'', //房间名称
                tenantStatus:undefined,
                roomTotal: 0,
   
                multipleRoomSelection: [],//房间表格数据多选

                formLabelWidth: '120px',

                drawer: false,//右侧抽屉
                recordData:[],
                drawerRoomName:'',
                drawerBuildingName:'',
                drawerFloorName:'',
        
            }
        },
        created(){
            this.getRoomList();
            
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
            //跳转房间新增（详情）页
            toRoomDetail(type,data){  
                let roomId = undefined;
                if(type =='edit'){
                    roomId = data.roomId;
                }      
                this.$router.push({ 
                    path: "/parkmanage/roomDetail", 
                    query:{
                        type,
                        roomId
                    }
                });
            },
            //字典映射
            formatRentType(row, column, cellValue) {
                const rentTypeMap = {
                    0: '元/m²/天',
                    1: '元/m²/月',
                    2: '元/天',
                    3: '元/月'
                };
                return rentTypeMap[cellValue] || cellValue;
            },

            //获取房间表格数据
            getRoomList(){
                this.roomtableloading = true;
                const query = {
                    pageNum:this.pageNum, //当前页
                    pageSize: this.pageSize,
                    buildingName:this.buildingName,
                    roomName:this.roomName,
                    tenantStatus:this.tenantStatus,
                }
                listRoom(query).then(res=>{      
                      
                    this.roomData = res.list;
                    console.log('房间数据列表',this.roomData);
                    
                    this.roomTotal = res.total;
                    this.roomtableloading = false;
                    
                }).catch(()=>{

                });
            },

            //查询表格重置
            formReset(){
                this.buildingName = ''; //楼宇名称
                this.roomName = ''; //房间名称
                this.tenantStatus = undefined;
                this.getRoomList();
            },

            //删除房间方法
            toDeleteRoom(roomIds){
                deleteRoom(roomIds).then(res => {
                    if(res.status == 200){
                        this.$message({
                            type: 'success',
                            message: res.message,
                        });
                        this.getRoomList();
                    }else{
                        this.$message({
                            type: 'danger',
                            message: res.message,
                        })
                    }
                    
                }).catch(() => {
                    
                })
            },

            //删除房间（批量）
            deleteRooms(){
                
                this.$confirm(`确认删除已选的${this.multipleRoomSelection.length}条房间信息？`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    center: true
                }).then(() => {
                    const roomIds = this.multipleRoomSelection.map(({ roomId }) => roomId);     
                    this.toDeleteRoom(roomIds);
                    
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },

            //删除房间（单个）
            deleteOnlyRoom(row){
                this.$confirm(`确认删除当前房间信息？`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    center: true
                }).then(() => {
                    const roomIds = row.roomId;
                    this.toDeleteRoom(roomIds);
                    
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },

            //修改房间上架状态
            toRoomStatus(row){
                const data ={
                    roomId:row.roomId,
                    status:row.status === false ? "0" : "1"
                }
                roomStatus(data).then(res=>{
                    if(res.status == 200){
                        this.$message.success(res.message);
                    }else{
                        this.$message.error(res.message);
                    }
                    this.getRoomList();
                    
                }).catch(()=>{

                })
            },

            //多选与全选
            toggleSelection(rows) {
                if (rows) {
                rows.forEach(row => {
                    this.$refs.multipleTable.toggleRowSelection(row);
                });
                } else {
                this.$refs.multipleTable.clearSelection();
                }
            },

            //表格记录选择
            handleSelectionChange(val) {
                this.multipleRoomSelection = val;
            },

            //每页条数变化
            handleSizeChange(val) {
                this.pageSize = val;
                this.getRoomList();
            },

            //当前页变化
            handleCurrentChange(val) {
                this.pageNum = val;
                this.getRoomList();
            },

            //查看记录
            viewRecord(row){
                this.drawerRoomName = row.roomName;
                this.drawerBuildingName = row.buildingName;
                this.drawerFloorName = row.floorName;
                this.drawer = true;
                const roomId = row.roomId;
                roomRecord(roomId).then(res=>{
                    console.log('当前房间租赁记录',res);
                    this.recordData = res.data;
                    console.log(this.recordData);
                    
                }).catch(()=>{

                })
            },

            handleClose(){

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
        background-color: white;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        gap: 20px;
        margin: 20px;
        padding: 20px;

        // 查找租户样式
        .search-container{
            display: flex;
            align-items: center;
            gap: 40px;

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
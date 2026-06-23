<template>
    <div class="my-room-container">
        <!-- 标题 -->
        <div class="title">
            我的房间
        </div>

        <div class="my-room-container">
            <div class="my-room-content">
            
                <!-- 房间查询功能 -->
                <el-form 
                    :inline="true"
                    >
                    <!-- 房间名称 -->
                    <el-form-item
                        class="el-form-item-gap"
                        size="mini" 
                        label="房间名称："  
                        >
                        <el-input 
                            placeholder="请输入房间名称"
                            v-model="roomName"
                            >
                        </el-input>
                    </el-form-item>
                
                    <!-- 所属楼宇 -->
                    <el-form-item 
                        class="el-form-item-gap"
                        label="所属楼宇："  
                        size="mini" 
                        >
                        <el-input 
                            placeholder="请输入所属楼宇名称"
                            v-model="buildingName"
                            >
                        </el-input>
                    </el-form-item>

                    <!-- 所属园区 -->
                    <el-form-item 
                        class="el-form-item-gap"
                        label="所属园区："  
                        size="mini" 
                        >
                        <el-input 
                            placeholder="请输入所属园区名称"
                            v-model="parkName"
                            >
                        </el-input>
                    </el-form-item>

                    <!-- 查询与重置 -->
                    <el-form-item 
                        class="el-form-item-gap"
                        size="mini">
                        <el-radio-group>
                            <el-button 
                                type="primary"
                                size="mini"
                                @click="searchRoom()"
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
                    :data="myRoomData"
                    tooltip-effect="dark"
                    v-loading="roomTableloading"
                    element-loading-text="数据加载中"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255,1)"
                    >

                    <!-- <el-table-column
                        type="selection"
                        width="55">
                    </el-table-column> -->

                    <el-table-column
                        prop="parkName"
                        label="所属园区"
                        width="100"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="roomName"
                        label="房间名称"
                        width="100"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="buildingName"
                        label="所属楼宇"
                        width="100"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="floorName"
                        label="所属楼层"
                        width="100"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="area"
                        label="面积（平方米）"
                        width="120"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="tenantMoney"
                        label="租金（元）"
                        width="120"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="tenantMoneyType"
                        label="租金类型"
                        :formatter="formatRentType"
                        width="100"
                        >
                    </el-table-column>

                    <el-table-column
                        prop="applyTime"
                        label="申请时间"
                        width="160"
                        >
                        <template slot-scope="scope">{{ scope.row.applyTime }}</template>
                    </el-table-column>

                    <el-table-column
                        prop="approvalStatus"
                        label="审批状态"
                        width="100"
                        >
                        <template slot-scope="scope">
                            <el-button 
                                v-if="scope.row.approvalStatus == 0" 
                                type="warning" 
                                plain 
                                disabled
                                size="mini"
                                >
                                待审批
                            </el-button>
                            <el-button 
                                v-else-if="scope.row.approvalStatus == 1"
                                type="success" 
                                plain 
                                disabled
                                size="mini"
                                >
                                审批通过
                            </el-button>
                            <el-button 
                                v-else-if="scope.row.approvalStatus == 2"
                                type="success" 
                                plain 
                                disabled
                                size="mini"
                                >
                                已拒绝
                            </el-button>
                            <el-button 
                                v-else-if="scope.row.approvalStatus == 3"
                                type="success" 
                                plain 
                                disabled
                                size="mini"
                                >
                                已取消
                            </el-button>
                        </template>   
                    </el-table-column>

                    <el-table-column
                        prop="tenantStatus"
                        label="房屋状态"
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
                                退租
                            </el-button>
                            <el-button 
                                v-else-if="scope.row.tenantStatus == 1"
                                type="success" 
                                plain 
                                disabled
                                size="mini"
                                >
                                在租
                            </el-button>
                        </template>   
                    </el-table-column>

                    <el-table-column
                        prop="startTime"
                        label="申请租赁开始时间"
                        width="160">
                        <template slot-scope="scope">{{ scope.row.startTime }}</template>
                    </el-table-column>

                    <el-table-column
                        prop="endTime"
                        label="申请租赁结束时间"
                        width="160">
                        <template slot-scope="scope">{{ scope.row.endTime }}</template>
                    </el-table-column>

                    <el-table-column
                        label="操作"
                        fixed="right"
                        width="160"
                        >
                        <template slot-scope="scope">
                            <!-- 房屋详情 -->
                            <el-button
                                type="text"
                                size="mini"
                                @click="viewDetail(scope.row)"
                                v-if="scope.row.approvalStatus == 0"
                            >
                                房屋详情
                            </el-button>

                            <!-- 取消申请 -->
                            <el-button 
                                v-if="scope.row.approvalStatus == 0"
                                type="text"
                                size="mini"
                                @click="toCancelRoom(scope.row.applicationId)"
                            >
                                取消申请
                            </el-button>
                    
                            <!-- 合同 -->
                            <el-button 
                                v-if="scope.row.tenantStatus == '0' || scope.row.tenantStatus == '1'"
                                type="text"
                                size="mini"
                                @click="toContractDetail(scope.row.roomId)"
                                >
                                合同
                            </el-button>
                            
                        </template>
                        
                    
                    </el-table-column>
                </el-table>

                <!-- 分页器 -->
                <div class="pagination">
                    <span></span>
                    <el-pagination
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange"
                        :current-page="pageNum"
                        :page-sizes="[5,10]"
                        :page-size="pageSize"
                        layout="total, sizes, prev, pager, next, jumper"
                        :total="total"
                        >
                    </el-pagination>
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
                            <template slot-scope="scope">
                                <span>{{timeTenantTime(scope.row)}}</span>
                            </template>
                        </el-table-column>

                        <!-- 身份证 -->
                        <el-table-column 
                            property="idNum" 
                            label="身份证" 
                            width="120"
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
import { listMyRoom,cancelRoom } from '../../api/tenant/room';
import { roomRecord } from '../../api/park/room';
    export default{
        name:"my-room",
        components:{},
        data(){
            return{
                roomTableloading:true,
                myRoomData: [],//我的房间数据
                pageNum:1,
                pageSize:5,
                buildingName:'',
                parkName:'',
                roomName:'',
                total:0,

                drawer: false,//右侧抽屉
                recordData:[],
                drawerRoomName:'',
                drawerBuildingName:'',
                drawerFloorName:'',
                // multipleSelection: [],

                
            } 
        },
        created(){
            this.getMyRoomList();
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
            //获取我的房间信息
            getMyRoomList(){
                this.roomTableloading=true;
                const queryData={
                    pageNum:this.pageNum,
                    pageSize:this.pageSize,
                    buildingName:this.buildingName,
                    parkName:this.parkName,
                    roomName:this.roomName,
                }
                listMyRoom(queryData).then(res=>{
                    console.log('我的房间',res);
                    
                    this.myRoomData =res.list;
                    this.total = res.total;
                    this.roomTableloading=false;
                }).catch(()=>{

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

            //取消申请
            toCancelRoom(applicationId){
                cancelRoom(applicationId).then(res=>{
                    if(res.status == 200){
                        this.$message.success(res.message);
                        this.getMyRoomList();
                    }else{
                        this.$message.error(res.message);
                    }
                }).catch(()=>{

                })
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

            //查询
            searchRoom(){
                this.getMyRoomList();
            },

            //重置
            resetForm(){
                this.buildingName=''
                this.parkName=''
                this.roomName=''
                this.getMyRoomList();
            },
            
            //每页条数
            handleSizeChange(val) {
                console.log(`每页 ${val} 条`);
                this.pageSize = val;
                this.getMyRoomList();
            },

            //当前页
            handleCurrentChange(val) {
                console.log(`当前页: ${val}`);
                this.pageNum = val;
                this.getMyRoomList();
            },

            //去合同详情
            toContractDetail(roomId){
                this.$router.push({
                    path:'/tenantMyRoom/tenantContract',
                    query:{
                        roomId
                    }
                })
            }
            

        }
    }
</script>
<style lang="scss" scoped>
.my-room-container{
    box-sizing: border-box;

    //标题样式
    .title{
        padding:20px 15px;
        font-weight: bold;
        background-color: white;
        font-size: 18px;
    }

    .my-room-container{
        padding: 20px;
        background-color: #f1f2f6;
        box-sizing: border-box;
        font-weight: normal;

        .my-room-content{
            padding: 20px;
            background-color: white;
            box-sizing: border-box;

            .pagination{
                display: flex;
                justify-content: space-between;
                margin-top: 10px;
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
}

.el-form-item-gap{
    padding-right: 20px;
}
.center-select {
  display: flex;
  justify-content: center;
}

</style>
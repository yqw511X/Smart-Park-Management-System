<template>
    <div class="tenant-container">
        <!-- 标题 -->
        <div class="title">
            楼宇管理
        </div>

        <div class="tenant-content">
            <!-- 表单区域 -->
            <div class="form-container">

                <!-- 楼宇查询 -->
                <div class="search-container">
                    <div class="search">
                        <span class="tip">楼宇名称：</span>
                        <el-input 
                            class="input"
                            v-model="buildingName" 
                            placeholder="请输入"
                            size="mini"
                            >
                        </el-input>
                    </div>
                    <div class="button">
                        <el-button 
                            type="primary"
                            size="mini"
                            @click="searchBuilding()"
                            >
                            查询
                        </el-button>
                        <el-button 
                            size="mini"
                            @click="clearBuildingName()"
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
                        @click="addBuildingVisible = true"
                        size="mini"
                        >
                        新建
                    </el-button>

                    <el-button
                        v-if="multipleBuildingSelection.length >0"
                        type="danger"
                        icon="el-icon-delete"
                        @click="deleteBuildings()"
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
                        :data="buildingData"
                        tooltip-effect="dark"
                        style="width: 100%"
                        @selection-change="buildingSelectionChange"
                        size="mini"
                        v-loading="buildingtableloading"
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
                            width="160">
                        </el-table-column>

                        <!-- 楼宇名称 -->
                        <el-table-column
                            prop="buildingName"
                            label="所属楼宇"
                            width="160">
                        </el-table-column>

                        <!-- 备注 -->
                        <el-table-column
                            prop="remark"
                            label="备注"
                            width="160"
                            show-overflow-tooltip>
                        </el-table-column>

                        <!-- 创建时间 -->
                        <el-table-column
                            prop="createTime"
                            label="创建时间"
                            width="250">
                        </el-table-column>

                        <!-- 创建人 -->
                        <el-table-column
                            prop="createBy"
                            label="创建人"
                            width="160"
                            >
                        </el-table-column>
        
                        <!-- 操作 -->
                        <el-table-column
                            prop="func"
                            label="操作"
                            show-overflow-tooltip
                        >
                            <template slot-scope="scope">

                                <!-- 编辑按钮 -->
                                <el-button
                                    size="mini"
                                    type="text"
                                    @click="handleEdit(scope.$index, scope.row)"
                                >
                                    编辑
                                </el-button>

                                <!-- 楼层按钮 -->
                                <el-button 
                                    type="text"
                                    size="mini"
                                    @click="showFloor(scope.row)">
                                    楼层
                                </el-button>

                                <!-- 删除按钮 -->
                                <el-button
                                size="mini"
                                type="text"
                                @click="deleteOnlyBuilding(scope.row)">删除</el-button>
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
                            :current-page="currentPage"
                            :page-sizes="[5,10]"
                            :page-size="pageSize"
                            layout="total, sizes, prev, pager, next, jumper"
                            :total="total"
                            size="mini"
                            >
                        </el-pagination>
                    </div>

                    <!-- 弹窗表单 -->
                    <!-- 创建楼宇 -->
                    <el-dialog 
                        title="创建楼宇" 
                        :visible.sync="addBuildingVisible"
                        class="form"
                        size="mini"
                        >
                        <el-form 
                            :model="addBuildingForm" 
                            :rules="addBuildingRules" 
                            ref="addBuildingForm" 
                            label-width="100px" 
                            size="mini"
                            >

                            <!-- 账户名 -->
                            <el-form-item 
                                label="楼宇名称：" 
                                prop="buildingName">
                                <el-input 
                                    v-model="addBuildingForm.buildingName"
                                    style="width: 500px"
                                    >
                                </el-input>
                            </el-form-item>

                            <!-- 备注（文本框） -->
                            <el-form-item 
                                label="备注：" 
                                prop="remark">
                                <el-input
                                    v-model="addBuildingForm.remark"
                                    type="textarea"
                                    style="width: 500px"
                                    >
                                </el-input>
                            </el-form-item>
                        </el-form>

                        <!-- 底部栏 -->
                        <div slot="footer" class="dialog-footer">
                            <!-- 取消按钮 -->
                            <el-button 
                                @click="cancelAddBuilding()"
                                size="mini"
                                >取 消</el-button>
                            <!-- 确定按钮 -->
                            <el-button
                                size="mini" 
                                type="primary" 
                                @click="toAddBuilding('addBuildingForm')"
                                >
                                确 定
                            </el-button>
                        </div>
                    </el-dialog>

                     <!-- 编辑楼宇 -->
                    <el-dialog 
                        title="编辑楼宇" 
                        :visible.sync="editBuildingVisible"
                        class="form"
                        size="mini"
                        >
                        <el-form 
                            :model="editBuildingForm" 
                            :rules="editBuildingRules" 
                            ref="editBuildingForm" 
                            label-width="100px" 
                            size="mini"
                            >

                            <!-- 账户名 -->
                            <el-form-item 
                                label="楼宇名称：" 
                                prop="buildingName">
                                <el-input 
                                    v-model="editBuildingForm.buildingName"
                                    style="width: 500px"
                                    >
                                </el-input>
                            </el-form-item>

                            <!-- 备注（文本框） -->
                            <el-form-item 
                                label="备注：" 
                                prop="remark">
                                <el-input
                                    v-model="editBuildingForm.remark"
                                    type="textarea"
                                    style="width: 500px"
                                    >
                                </el-input>
                            </el-form-item>
                        </el-form>

                        <!-- 底部栏 -->
                        <div slot="footer" class="dialog-footer">
                            <!-- 取消按钮 -->
                            <el-button 
                                @click="cancelEditBuilding()"
                                size="mini"
                                >
                                取 消
                            </el-button>
                            <!-- 确定按钮 -->
                            <el-button
                                size="mini"
                                type="primary" 
                                @click="toEditBuilding('editBuildingForm')"
                                >
                                确 定
                            </el-button>
                        </div>
                    </el-dialog>

                    <!-- 楼层列表 -->
                    <el-dialog 
                        title="楼层列表" 
                        :visible.sync="dialogFloorVisible"
                        class="form"
                        size="mini"
                        width="60%"
                        @close="floorTableClose()"
                        >

                        <div class="btn-add">
                            <!-- 新建按钮 -->
                            <el-button 
                                type="primary"
                                icon="el-icon-plus"
                                style="margin-bottom: 10px;"
                                @click="dialogFloorAddVisible = true"
                                size="mini"
                            >
                                新建
                            </el-button>

                            <!-- 删除按钮 -->
                            <el-button
                                v-if="multipleFloorSelection.length >0"
                                type="danger"
                                icon="el-icon-delete"
                                @click="deleteFloor()"
                                size="mini"
                                >
                                删除
                            </el-button>

                        </div>
                        

                        <!-- 表格 -->
                        <el-table
                            ref="floorTable"
                            :data="floorData"
                            tooltip-effect="dark"
                            style="width: 100%"
                            @selection-change="floorSelectionChange"
                            size="mini"
                            v-loading="floortableloading"
                            element-loading-text="数据加载中"
                            element-loading-spinner="el-icon-loading"
                            element-loading-background="rgba(255, 255, 255,1)"
                            >

                            <!-- 多选框 -->
                            <el-table-column
                            type="selection"
                            width="55">
                            </el-table-column>

                            <!-- 楼层 -->
                            <el-table-column
                                prop="floorNum"
                                label="楼层"
                                width="120"
                                >
                            </el-table-column>

                            <!-- 楼层名称 -->
                            <el-table-column
                                prop="floorName"
                                label="楼层名称"
                                width="120">
                            </el-table-column>

                            <!-- 创建时间 -->
                            <el-table-column
                                prop="createTime"
                                label="创建时间"
                                width="240">
                            </el-table-column>

                            <!-- 创建人 -->
                            <el-table-column
                                prop="createBy"
                                label="创建人"
                                width="120">
                            </el-table-column>

                            <!-- 操作 -->
                            <el-table-column
                                prop="func"
                                label="操作"
                                show-overflow-tooltip
                            >
                                <template slot-scope="scope">

                                    <!-- 编辑按钮 -->
                                    <el-button
                                        size="mini"
                                        type="text"
                                        @click="handleFloorEdit(scope.row)"
                                    >
                                        编辑
                                    </el-button>

                                    <!-- 删除按钮 -->
                                    <el-button
                                        size="mini"
                                        type="text"
                                        @click="deleteOnlyFloor(scope.row)"
                                        >
                                        删除
                                    </el-button>
                                </template>
                            </el-table-column>

                        </el-table>

                        <!-- 底部栏 -->
                        <div 
                            slot="footer" 
                            class="dialog-footer"
                            >
                            <!-- 取消按钮 -->
                            <el-button 
                                @click="dialogFloorVisible = false"
                                size="mini"
                                >
                                取 消
                            </el-button>
                            <!-- 确定按钮 -->
                            <el-button 
                                type="primary" 
                                @click="dialogFloorVisible = false"
                                size="mini"
                                >
                                确 定
                            </el-button>
                        </div>
                    </el-dialog>

                    <!-- 楼层创建弹窗 -->
                    <el-dialog 
                        title="创建楼层" 
                        :visible.sync="dialogFloorAddVisible"
                        class="form"
                        size="mini"
                        @close="cancelFloorAdd" 
                        >
                        <el-form 
                            :model="addFloorForm" 
                            :rules="addFloorRules" 
                            ref="addFloorRuleForm"  
                            class="demo-ruleForm"
                            size="mini"
                            
                            >

                            <!-- 楼层 -->
                            <el-form-item 
                                label="楼层：" 
                                prop="floorNum">
                                <el-input-number 
                                    v-model="addFloorForm.floorNum" 
                                    controls-position="right" 
                                    @change="handleChangeFloor" 
                                    :min="1" 
                                    :max="10"
                                    size="mini"
                                    >
                                </el-input-number>
                            </el-form-item>

                            <!-- 楼层名称 -->
                            <el-form-item 
                                label="楼层名称：" 
                                prop="floorName">
                                <el-input 
                                    v-model="addFloorForm.floorName"
                                    placeholder="请输入楼层名称"
                                    >
                                </el-input>
                            </el-form-item>
                        </el-form>

                        <!-- 底部栏 -->
                        <div slot="footer" class="dialog-footer">
                            <!-- 取消按钮 -->
                            <el-button
                                size="mini" 
                                @click="cancelFloorAdd"
                                >
                                取 消
                            </el-button>
                            <!-- 确定按钮 -->
                            <el-button
                                size="mini" 
                                type="primary" 
                                @click="toAddFloor('addFloorRuleForm')"
                                >
                                确 定
                            </el-button>
                        </div>
                    </el-dialog>

                    <!-- 楼层编辑弹窗 -->
                    <el-dialog 
                        title="编辑楼层" 
                        :visible.sync="dialogFloorEditVisible"
                        class="form"
                        size="mini"
                        >
                        <el-form 
                            :model="editFloorForm" 
                            :rules="editFloorRules" 
                            ref="editFloorRuleForm"  
                            class="demo-ruleForm"
                            size="mini"
                            >

                            <!-- 楼层 -->
                            <el-form-item 
                                label="楼层：" 
                                prop="floorNum">
                                <el-input
                                    v-model="editFloorForm.floorNum"
                                    size="mini"
                                    >
                                </el-input>
                            </el-form-item>

                            <!-- 楼层名称 -->
                            <el-form-item 
                                label="楼层名称：" 
                                prop="floorName">
                                <el-input 
                                    v-model="editFloorForm.floorName"
                                    placeholder="请输入楼层名称"
                                    >
                                </el-input>
                            </el-form-item>
                        </el-form>

                        <!-- 底部栏 -->
                        <div slot="footer" class="dialog-footer">
                            <!-- 取消按钮 -->
                            <el-button
                                size="mini" 
                                @click="cancelFloorEdit"
                                >
                                取 消
                            </el-button>
                            <!-- 确定按钮 -->
                            <el-button
                                size="mini" 
                                type="primary" 
                                @click="toEditFloor('editFloorRuleForm')"
                                >
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
import {
        listBuilding, 
        addBuilding, 
        editBuilding,
        deleteBuilding
        } from "./../../../api/park/building"

import {
        listFloor,
        addFloor,
        editFloor,
        deleteFloor
        } from "./../../../api/park/floor"

export default{
    name:"park",
    data(){
        return{
            floortableloading:true,
            buildingtableloading:true,

            formLabelWidth: '120px',
            buildingData: [],//楼宇表格数据
            multipleBuildingSelection: [],//楼宇多选数据

            pageNum:1,
            pageSize:5,
            buildingName:'',//楼宇分页查询参数
            currentPage:1, //当前页
            total: 0,//记录条数

            addBuildingVisible: false,//创建楼宇表单弹窗显示控制
            addBuildingForm: {
                buildingName:'',
                remark: '',
            },//创建楼宇表单信息
            addBuildingRules: {
                buildingName:[
                    { 
                        required: true, 
                        message: '请输入必填字段', 
                        trigger: 'blur'
                    }
                ],
                remark:[
                    {  
                        trigger: 'blur'
                    }
                ]
            },//创建楼宇表单校验规则

            editBuildingVisible: false,//编辑楼宇表单弹窗显示控制
            editBuildingForm: {
                buildingId:'',
                buildingName:'',
                remark: '',
            },//编辑楼宇表单信息
            editBuildingRules: {
                buildingName:[
                    { 
                        required: true, 
                        message: '请输入必填字段', 
                        trigger: 'blur'
                    }
                ],
                remark:[
                    {  
                        trigger: 'blur'
                    }
                ]
            },//编辑楼宇表单校验规则

            floorData: [],//楼层列表数据
            dialogFloorVisible:false,//楼层表单弹窗显示控制
            multipleFloorSelection: [],
            dialogFloorAddVisible:false,//创建楼层表单弹窗显示控制
            currentBuildingId:0,
            addFloorForm: {
                buildingId:0,
                floorName:"",
                floorNum:0
            },//创建楼层表单信息
            addFloorRules: {
                floorNum:[
                    { 
                        required: true, 
                        message: '请输入必填字段', 
                        trigger: 'blur'
                    }
                ],
                floorName:[
                    {  
                        required: true, 
                        message: '请输入必填字段', 
                        trigger: 'blur'
                    }
                ]
            },//表单校验规则

            dialogFloorEditVisible:false,
            editFloorForm:{
                buildingId:0,
                floorId:0,
                floorName:'',
                floorNum:0
            },//编辑楼层表单信息
            editFloorRules: {
                floorNum:[
                    { 
                        required: true, 
                        message: '请输入必填字段', 
                        trigger: 'blur'
                    }
                ],
                floorName:[
                    {  
                        required: true, 
                        message: '请输入必填字段', 
                        trigger: 'blur'
                    }
                ]
            },//表单校验规则

            
            
        }
    },
    created(){
        this.getBuildingList();
    },
    methods:{
        floorTableClose(){
            
        },
        //获取楼层列表
        getFloorList(buildingId){
            this.floortableloading =true;
            listFloor(buildingId).then(res => {
                if(res.status == 200){
                    this.floorData = res.data;
                    this.floortableloading =false;
                }else{
                    this.$message.error(res.message);
                }
            }).catch(() => {
                
            })
            
        },

        //查看楼层信息
        showFloor(row){
            this.dialogFloorVisible = true;
            this.addFloorForm.buildingId = row.buildingId;
            this.currentBuildingId = row.buildingId;
            const buildingId = row.buildingId;
            this.getFloorList(buildingId);
        },

        //创建楼层选择楼层
        handleChangeFloor(value) {
            this.addFloorForm.floorNum = value;
        },

        //创建楼层方法
        toAddFloor(formName){
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    const query = this.addFloorForm;
                    addFloor(query).then(res=>{
                        if(res.status == 200){
                            this.$message.success(res.message);
                            this.getFloorList(this.addFloorForm.buildingId);
                            this.cancelFloorAdd();
                        }else{
                            this.$message.error(res.message);
                        }
                    }).catch(()=>{

                    })
                } else {
                    return false;
                }
            });
           
        },

        //取消新增楼层
        cancelFloorAdd(){
            this.dialogFloorAddVisible = false;
            this.addFloorForm.floorName = '';
            this.addFloorForm.floorNum = 0;
        },
        
        //查看编辑楼层
        handleFloorEdit(row){
            this.dialogFloorEditVisible = true;
            this.editFloorForm = row;
        },

        //编辑楼层信息
        toEditFloor(formName){
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    const data = this.editFloorForm;
                    editFloor(data).then(res=>{
                        if(res.status == 200){
                            this.$message.success(res.message);
                            this.getFloorList(this.editFloorForm.buildingId);
                            this.cancelFloorEdit();
                        }else{
                            this.$message.error(res.message);
                        }
                    }).catch(()=>{

                    })
                } else {
                    return false;
                }
            });
        },

        //取消编辑楼层信息
        cancelFloorEdit(){
            this.dialogFloorEditVisible =  false
        },

        //楼层信息记录选择
        floorSelectionChange(val) {
            this.multipleFloorSelection = val;   
            console.log(this.multipleFloorSelection);
            console.log(this.currentBuildingId);
            
        },
        
        //删除楼层信息
        toDeleteFloor(floorIds){
            deleteFloor(floorIds).then(res => {
                console.log(res);
                if(res.status === 200){
                    this.$message({
                        type: 'success',
                        message: res.message,
                    });
                    this.getFloorList(this.currentBuildingId);
                }else{
                    this.$message({
                        type: 'danger',
                        message: res.message,
                    })
                }
            }).catch(() => {
                
            })
        },

        //删除楼层（批量）
        deleteFloor(){
            this.$confirm(`确认删除已选的${this.multipleFloorSelection.length}条楼层信息？`, '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning',
                center: true
            }).then(() => {
                const floorIds = this.multipleFloorSelection.map(({ floorId }) => floorId);
                this.toDeleteFloor(floorIds);
                
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消删除'
                });
            });
        },

        //删除楼层（单个）
        deleteOnlyFloor(row){
            console.log(row);
            
            this.$confirm(`确认删除当前楼层信息？`, '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning',
                center: true
            }).then(() => {
                const floorId = row.floorId;
                this.toDeleteFloor(floorId);
                
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消删除'
                });
            });
        },

        //每页条数变化
        handleSizeChange(val) {
            this.pageSize = val;
            this.getBuildingList();
        },

        // 当前页变化
        handleCurrentChange(val) {
            this.pageNum = val;
            this.getBuildingList();
        },

        //获取楼宇列表（分页）
        getBuildingList(){
            this.buildingtableloading = true;
            const queryParams = {
                pageNum: this.pageNum,      // 必填，页码
                pageSize: this.pageSize,    // 必填，每页大小
                buildingName: this.buildingName // 可选，楼宇名称
            }
            listBuilding(queryParams).then(res => {
                this.buildingData = res.list;
                this.total=res.total;
                this.buildingtableloading = false;
            }).catch(() => {
                
            })
        },

        //用户查询楼宇
        searchBuilding(){
            this.getBuildingList();
        },

        //用户重置查询楼宇信息
        clearBuildingName(){
            this.buildingName = '';
            this.getBuildingList();
        },

        //创建楼宇
        toAddBuilding(formName) {
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    const data = this.addBuildingForm;
                    addBuilding(data).then(res => {
                    this.$message.success(res.message);
                    this.addBuildingVisible = false;
                    this.getBuildingList();
                    this.addBuildingForm = {
                        buildingName:'',
                        remark: '',
                    }
                }).catch(() => {
                    
                })
                } else {
                    return false;
                }
            });

            
        },

        //取消创建楼宇
        cancelAddBuilding(){
            this.addBuildingVisible = false;
            this.addBuildingForm =  {
                buildingName:'',
                remark: '',
            };
        },

        //楼宇记录编辑
        handleEdit(index, row) {
            this.editBuildingForm = {
                buildingId: row.buildingId,
                buildingName: row.buildingName,
                remark: row.remark
            }
            this.editBuildingVisible = true;
        },

        //提交编辑楼宇
        toEditBuilding(formName) {
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    const data = this.editBuildingForm;
                    editBuilding(data).then(res => {
                        if(res.status == 200){
                            this.$message.success(res.message);
                            this.editBuildingVisible = false;
                            this.getBuildingList();
                        }else if (res.status == 500){
                            this.$message.error(res.message);
                        }  
                }).catch(() => {

                })
                } else {
                    return false;
                }
            });

            
        },

        //取消编辑楼宇
        cancelEditBuilding(){
            this.editBuildingVisible = false;
        },

        //楼宇表格记录选择
        buildingSelectionChange(val) {
            this.multipleBuildingSelection = val;   
        },

        //删除楼宇
        toDeleteBuilding(buildingIds){
            
            deleteBuilding(buildingIds).then(res => {
                console.log(res);
                if(res.status === 200){
                    this.$message({
                        type: 'success',
                        message: res.message,
                    });
                    this.getBuildingList();
                }else{
                    this.$message({
                        type: 'danger',
                        message: res.message,
                    })
                }
                
            }).catch(() => {
                
            })
        },

        //删除楼宇（批量）
        deleteBuildings(){
            this.$confirm(`确认删除已选的${this.multipleBuildingSelection.length}条楼宇信息？`, '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning',
                center: true
            }).then(() => {
                const buildingIds = this.multipleBuildingSelection.map(({ buildingId }) => buildingId);
                this.toDeleteBuilding(buildingIds);
                
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消删除'
                });
            });
        },

        //删除楼宇（单个）
        deleteOnlyBuilding(row){
            this.$confirm(`确认删除当前楼宇信息？`, '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning',
                center: true
            }).then(() => {
                const buildingId = row.buildingId;
                this.toDeleteBuilding(buildingId);
                
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消删除'
                });
            });
        },

        resetForm(formName) {
            this.$refs[formName].resetFields();
        }
    },


}
</script>

<style lang="scss" scoped>
.tenant-container{
    box-sizing: border-box;
    

    // 大字标题样式
    .title{
        font-size: 18px;
        font-weight: bold;
        background-color: white;
        padding:20px 15px;
    }
    
    .tenant-content{
        padding: 20px;
        box-sizing: border-box;

        // 表单区域样式
        .form-container{
            background-color: white;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            gap: 20px;
            padding: 15px;

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

                
            }
        }
    }
    
}
</style>
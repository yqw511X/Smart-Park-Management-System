<template>
    <div class="tenant-container">
        <!-- 标题 -->
        <div class="title"
        style="padding:20px 15px;
                font-weight: bold;
                background-color: white">
            租户管理
        </div>

        <div class="tenant-content">
            <!-- 表单区域 -->
            <div class="form-container">

                <!-- 租户查询 -->
                <div class="search-container">
                    <div class="search">
                        <span class="tip">租户名称：</span>
                        <el-input 
                            class="input"
                            v-model="username" 
                            placeholder="请输入租户名称"
                            size="mini"
                            >
                        </el-input>
                    </div>
                    <div class="button">
                        <el-button 
                            size="mini" 
                            type="primary"
                            @click="searchRenter()"
                            >
                            查询
                        </el-button>
                        <el-button 
                            size="mini" 
                            @click="clearForm()"
                            >
                            重置
                        </el-button>
                    </div>
                </div>
                
                <!-- 新建按钮 -->
                <div class="add-btn">
                    <el-button
                        type="primary"
                        icon="el-icon-plus"
                        @click="handleAdd"
                        size="mini"
                        >
                        新建
                    </el-button>

                    <el-button
                        v-if="multipleRenterSelection.length >0"
                        type="danger"
                        icon="el-icon-plus"
                        @click="deleteRenter"
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
                        :data="renterData"
                        tooltip-effect="dark"
                        style="width: 100%"
                        @selection-change="handleSelectionChange"
                        size="mini"
                        v-loading="rentertableloading"
                        element-loading-text="数据加载中"
                        element-loading-spinner="el-icon-loading"
                        element-loading-background="rgba(255, 255, 255,1)" 
                        >
                        <!-- 选择 -->
                        <el-table-column
                            type="selection"
                            width="55">
                        </el-table-column>

                        <!-- 租户名称 -->
                        <el-table-column
                            prop="userName"
                            label="租户名称"
                            width="80">
                        </el-table-column>

                        <!-- 身份证 -->
                        <el-table-column
                            prop="idNum"
                            label="身份证号码"
                            width="160">
                        </el-table-column>

                        <!-- 邮箱 -->
                        <el-table-column
                            prop="email"
                            label="邮箱"
                            width="160">
                        </el-table-column>

                        <!-- 联系电话 -->
                        <el-table-column
                            prop="phoneNumber"
                            label="联系电话"
                            width="120">
                        </el-table-column>

                        <!-- 家庭地址 -->
                        <el-table-column
                            prop="address"
                            label="家庭地址"
                            show-overflow-tooltip>
                        </el-table-column>

                        <!-- 租户状态 -->
                        <el-table-column
                            prop="status"
                            label="租户状态"
                            width="80"
                        >
                            <template slot-scope="scope">
                                <el-button 
                                    v-if="scope.row.status == false" 
                                    size="mini"
                                    type="info" 
                                    plain 
                                    disabled
                                >未租</el-button>
                                <el-button 
                                    v-else
                                    size="mini"
                                    type="success" 
                                    plain 
                                    disabled
                                >在租</el-button>
                            </template>   
                        </el-table-column>

                        <!-- 在租房间 -->
                        <el-table-column
                            prop="roomName"
                            label="在租房间"
                            width="100"
                            >
                        </el-table-column>

                        <!-- 操作 -->
                        <el-table-column
                            prop="address"
                            label="操作"
                            width="120"
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

                                <!-- 删除按钮 -->
                                <el-button
                                    size="mini"
                                    type="text"
                                    @click="deleteOnlyRenter(scope.row)">
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

                    <!-- 创建租户表单 -->
                    <el-dialog 
                        :title="dialogFormStatus" 
                        :visible.sync="dialogFormVisible"
                        size="mini"
                        @closed="resetForm"
                        >
                        <el-form 
                            :model="rentForm" 
                            :rules="rules" 
                            ref="rentForm" 
                            label-width="100px" 
                            class="demo-ruleForm"
                            >

                            <!-- 账户名 -->
                            <el-form-item 
                                label="账户名" 
                                prop="userName">
                                <el-input 
                                    v-model="rentForm.userName"
                                    style="width: 500px"
                                    >
                                </el-input>
                            </el-form-item>

                            <!-- 真实姓名 -->
                            <el-form-item 
                                label="真实姓名" 
                                prop="nickName">
                                <el-input 
                                    v-model="rentForm.nickName"
                                    style="width: 500px"
                                    >
                                </el-input>
                            </el-form-item>

                            <!-- 身份证号码 -->
                            <el-form-item 
                                label="身份证号码" 
                                prop="idNum">
                                <el-input v-model="rentForm.idNum" style="width: 500px"></el-input>
                            </el-form-item>

                            <!-- 邮箱 -->
                            <el-form-item 
                                label="邮箱" 
                                prop="email">
                                <el-input v-model="rentForm.email" style="width: 500px"></el-input>
                            </el-form-item>

                            <!-- 联系电话 -->
                            <el-form-item 
                                label="联系电话" 
                                prop="phonenumber">
                                <el-input 
                                    v-model="rentForm.phonenumber" 
                                    style="width: 500px"
                                    >
                                </el-input>
                            </el-form-item>

                            <!-- 家庭住址 -->
                            <el-form-item 
                                label="家庭住址" 
                                prop="address">
                                <el-input 
                                    v-model="rentForm.address" 
                                    style="width: 500px"
                                    >
                                </el-input>
                            </el-form-item>

                            <!-- 密码 -->
                            <el-form-item 
                                label="密码" 
                                prop="password">
                                <el-input v-model="rentForm.password" style="width: 500px"></el-input>
                            </el-form-item>

                            <!-- 确认密码 -->
                            <el-form-item 
                                label="确认密码" 
                                prop="confirmPassword">
                                <el-input v-model="rentForm.confirmPassword" style="width: 500px"></el-input>
                            </el-form-item>
                        </el-form>
                        <div slot="footer" class="dialog-footer">
                            <el-button 
                                @click="cancel"
                                >
                                取 消
                            </el-button>
                            <el-button 
                                type="primary" 
                                @click="submitForm('rentForm')"
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
import { listRenter,addRenter,listRenterId,deleteRenter,editRenter} from '../../api/renter/tenant';
    export default{
        name:"renter",
        data(){
            const validatePass = (rule, value, callback) => {
                if (!value) {
                    callback(new Error('请输入必填字段'));
                }

                // 1. 基础长度检查
                if (value.length < 6) {
                    callback(new Error('密码至少需要6个字符'));
                }

                // 2. 检查简单密码模式
                // 连续数字
                const sequentialNumbers = /(012|123|234|345|456|567|678|789|987|876|765|654|543|432|321|210){2,}/
                // 重复字符
                const repeatedChars = /(.)\1{2,}/
                // 键盘顺序
                const keyboardSequences = ['qwerty', 'asdfgh', 'zxcvbn', 'password', '123456']
                
                if (sequentialNumbers.test(value) || 
                    repeatedChars.test(value) ||
                    keyboardSequences.some(seq => value.toLowerCase().includes(seq))) {
                    callback(new Error('请避免使用连续数字或重复字符'))
                    return
                }

                // 3. 计算字符类型
                let typeCount = 0
                const types = {
                    hasLower: /[a-z]/.test(value),
                    hasUpper: /[A-Z]/.test(value),
                    hasNumber: /\d/.test(value),
                    hasSpecial: /[^A-Za-z0-9]/.test(value)
                }

                Object.values(types).forEach(hasType => {
                    if (hasType) typeCount++;
                    this.passwordStrength = typeCount;
                })

                // 4. 强度判断
                
                if (typeCount === 1) {
                    callback(new Error('请至少包含两种字符类型（字母、数字、特殊符号）'));
                } else if (typeCount === 2) {
                    // 强度为"中"，通过验证
                    callback();
                } else if (typeCount >= 3) {
                    // 强度为"高"，通过验证
                    callback();
                } else {
                    callback(new Error('密码不符合要求'));
                }
            };

            //再次输入密码校验
            const equalToPassword = (rule, value, callback) => {
                if (this.rentForm.password !== value) {
                    callback(new Error("两次输入的密码不一致"));
                } else {
                    callback();
                }
            };

            return{
                rentertableloading:true,
                renterData: [],
                pageNum:1, //当前页
                pageSize: 5,
                username:'',
                total: 0,
                multipleRenterSelection: [],
                dialogFormVisible: false,//创建表单弹窗显示控制
                dialogFormStatus:'',
                formLabelWidth: '120px',
                currentUserId:null,
                rentForm: {
                    userName: '',
                    nickName:'',
                    idNum:'',
                    email:'',
                    phonenumber:'',
                    address:'',
                    password: '',
                    confirmPassword: '',
                    roomId:'',
                },//创建租户表单信息
                rules: {
                    userName:[
                        { 
                            required: true, 
                            message: '请输入必填字段', 
                            trigger: 'blur'
                        }
                    ],
                    nickName:[
                        { 
                            required: true, 
                            message: '请输入必填字段', 
                            trigger: 'blur'
                        }
                    ],
                    idNum:[
                        { 
                            required: true, 
                            message: '请输入必填字段', 
                            trigger: 'blur'
                        }
                    ],
                    email:[
                        {
                            required: true, 
                            message: '请输入必填字段', 
                            trigger: 'blur'
                        }
                    ],
                    phonenumber:[
                        { 
                            required: true, 
                            message: '请输入必填字段', 
                            trigger: 'blur'
                        }
                    ],
                    address:[
                        { 
                            required: true, 
                            message: '请输入必填字段', 
                            trigger: 'blur'
                        }
                    ],
                    password: [
                        {
                            required: true, 
                            max: 20,
                            message: '密码最多20个字符',
                            trigger: ['blur', 'change']
                        },
                        { 
                            validator: validatePass, 
                            trigger: ['blur', 'change'] 
                        }
                    ],
                    confirmPassword: [
                        { 
                            required: true, 
                            message: '请再次输入密码', 
                            trigger: 'blur'
                        },
                        { 
                            validator: equalToPassword, 
                            trigger: ['blur', 'change'] 
                        }
                    ],
                },//表单校验规则

            }
        },
        created(){
            this.getRenterList();
        },
        methods:{
            //根据用户名查询租户列表
            getRenterList(){
                this.rentertableloading = true;
                const queryData = {
                    pageNum:this.pageNum, //当前页
                    pageSize: this.pageSize,
                    username:this.username,
                }
                listRenter(queryData).then(res=>{
                    this.renterData = res.rows;
                    this.total = res.total;
                    this.rentertableloading = false;
                }).catch(()=>{

                })
            },

            //根据ID查询租户列表
            getIdRenter(userId){

                listRenterId(userId).then(res=>{
                    this.rentForm = res.data;
                    console.log('租户',res);
                    
                }).catch(()=>{

                })
            },

            //新增租户表单验证(新增租户)
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        
                        if(this.dialogFormStatus == '新增租户'){
                            const data = this.rentForm;
                            addRenter(data).then(res=>{
                                console.log(res);
                                if (res.status == 200) {
                                    this.$message.success(res.message);
                                }else{
                                    this.$message.error(res.message);
                                }
                                this.dialogFormVisible = false;
                                
                                this.getRenterList();
                                this.rentForm = {
                                    userName: "",
                                    nickName:"",
                                    idNum:"",
                                    email:"",
                                    phonenumber:"",
                                    address:"",
                                    password: "",
                                    confirmPassword: "",
                                    userId:null,
                                }//租户表单信息
                            }).catch(()=>{

                            })
                        }else if(this.dialogFormStatus == '编辑租户'){
                            const editData = this.rentForm;
                            editData.userId = this.currentUserId;
                            editRenter(editData).then(res=>{
                                if (res.status == 200) {
                                    this.$message.success(res.message);
                                }else{
                                    this.$message.error(res.message);
                                }
                                this.dialogFormVisible = false;
                                this.getRenterList();
                                this.rentForm = {
                                    userName: "",
                                    nickName:"",
                                    idNum:"",
                                    email:"",
                                    phonenumber:"",
                                    address:"",
                                    password: "",
                                    confirmPassword: "",
                                }//租户表单信息
                            }).catch(()=>{

                            })
                        }

                        
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },

            //删除租户信息方法
            toDeleteRenter(userIds){
                deleteRenter(userIds).then(res => {
                    if(res.status == 200){
                        this.$message({
                            type: 'success',
                            message: res.message,
                        });
                        this.getRenterList();
                    }else{
                        this.$message({
                            type: 'danger',
                            message: res.message,
                        })
                    }
                }).catch(() => {
                    
                })
            },

            //删除租户（批量）
            deleteRenter(){
                this.$confirm(`确认删除已选的${this.multipleRenterSelection.length}条租户信息？`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    center: true
                }).then(() => {
                    const userIds = this.multipleRenterSelection.map(({ userId }) => userId);
                    this.toDeleteRenter(userIds);
                    this.getRenterList();
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },

            //删除租户（单个）
            deleteOnlyRenter(row){
                this.$confirm(`确认删除当前租户信息？`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    center: true
                }).then(() => {
                    const userId = row.userId;
                    this.toDeleteRenter(userId);
                    this.getRenterList();
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },

            //查询租户
            searchRenter(){
                this.getRenterList();
            },

            //重置查询
            clearForm(){
                this.username='';
                this.getRenterList();
            },

            //取消
            cancel(){
                this.dialogFormVisible = false;
                this.rentForm ={
                    userName: "",
                    nickName:"",
                    idNum:"",
                    email:"",
                    phonenumber:"",
                    address:"",
                    password: "",
                    confirmPassword: "",
                }//租户表单信息
            },

            //全选/全不选
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
                this.multipleRenterSelection = val;
            },

            //打开新建租户表单弹窗
            handleAdd() {
                this.dialogFormStatus = '新增租户';
                this.dialogFormVisible = true;
            },

            //表格记录编辑
            handleEdit(index, row) {
                console.log(row);
                
                this.currentUserId = row.userId;
                this.dialogFormStatus = '编辑租户';
                this.dialogFormVisible = true;
                this.getIdRenter(row.userId);
                
            },

            //取消
            resetForm(){
                this.rentForm ={
                    userName: "",
                    nickName:"",
                    idNum:"",
                    email:"",
                    phonenumber:"",
                    address:"",
                    password: "",
                    confirmPassword: "",
                }//租户表单信息
            },
            
            //每页条数变化
            handleSizeChange(val) {
                this.pageSize = val;
                this.pageNum = 1;
                this.getRenterList();
            },

            //当前页变化
            handleCurrentChange(val) {
                this.pageNum = val;
                this.getRenterList();
            },
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
            padding: 10px;

            // 查找租户样式
            .search-container{
                display: flex;
                align-items: center;
                gap: 40px;
                margin-top: 20px;

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
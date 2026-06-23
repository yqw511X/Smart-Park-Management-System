<template>
    <div class="add-repair-container">
        <!-- 标题 -->
        <div class="title">
            <span v-if="this.formStatus == 'add'">
                新建报修
            </span>
            <span v-if="this.formStatus == 'edit'">
                修改报修
            </span>
        </div>

        <div class="add-repair-container">
            <div class="add-repair-content">
                <el-form 
                    size="mini" 
                    :model="ruleForm" 
                    :rules="rules" 
                    ref="ruleForm" 
                    label-width="100px" 
                    class="demo-ruleForm"
                    >
                    <el-form-item 
                        label="联系人：" 
                        prop="contactName"
                        >
                        <el-input 
                            v-model="ruleForm.contactName"
                            >
                        </el-input>
                    </el-form-item>

                    <el-form-item 
                        label="联系电话：" 
                        prop="contactPhone"
                        >
                        <el-input 
                            v-model="ruleForm.contactPhone"
                            >
                        </el-input>
                    </el-form-item>

                    <el-form-item 
                        label="上门时间：" 
                        prop="visitTime"
                        >
                        <el-cascader
                            v-model="selectedPath"
                            :options="cascaderOptions"
                            :props="cascaderProps"
                            placeholder="请选择上门时间"
                            clearable
                            @change="handleCascaderChange"
                            @visible-change="handleCascaderVisibleChange"></el-cascader>
                        
                    </el-form-item>

                    <el-form-item 
                        label="报修区域：" 
                        prop="repairArea"
                        >
                        <el-select 
                            v-model="ruleForm.repairArea" 
                            placeholder="请选择报修区域"
                            >
                            <el-option 
                                label="基础设施" 
                                value="0"
                                >
                            </el-option>
                            <el-option 
                                label="水电设施" 
                                value="1"
                                >
                            </el-option>
                            <el-option 
                                label="厨房与卫生间设施" 
                                value="2"
                                >
                            </el-option>
                            <el-option 
                                label="暖与制冷系统" 
                                value="3"
                                >
                            </el-option>
                            <el-option 
                                label="公共区域" 
                                value="4"
                                >
                            </el-option>
                            <el-option 
                                label="固有家电" 
                                value="5"
                                >
                            </el-option>
                            <el-option 
                                label="安全设施" 
                                value="6"
                                >
                            </el-option>
                            
                        </el-select>
                    </el-form-item>

                    <el-form-item 
                        label="描述：" 
                        prop="remark"
                        >
                        <el-input type="textarea" v-model="ruleForm.remark"></el-input>
                    </el-form-item>

                    <el-form-item label="上传维修申请照片：" prop="name">
                        <el-upload
                            action="http://mashang.eicp.vip:5555/ms_stu_pro345/common/upload"
                            list-type="picture-card"
                            :on-preview="handlePictureCardPreview"
                            :on-success="handleSuccess"
                            :headers="uploadHeaders"
                            :file-list="imageFileList" 
                            :on-remove="handleRemove">
                            <i class="el-icon-plus"></i>
                        </el-upload>
                        <el-dialog :visible.sync="dialogVisible">
                            <img width="100%" :src="dialogImageUrl" alt="">
                        </el-dialog>
                    </el-form-item>
                </el-form>

                <div slot="footer">
                    <el-button
                        size="mini"
                        type="primary" 
                        @click="submitNewOrder"
                        >
                        提交
                    </el-button>
                    <el-button
                        size="mini" 
                        @click="closeOrder()"
                        >
                        关闭
                    </el-button>
                </div>
            </div>
        </div>
        
    </div>
    
</template>
<script>
import {myOrderCreate,myOrderUpdate,orderDetail} from './../../../api/tenant/order.js'
import { getToken } from '@/utils/auth'
    export default{
        name:"add-repair",
        components:{},
        data(){
            return{
                token: localStorage.getItem('token') || '',
                formStatus:'',
                repairOrderId:'',
                ruleForm: {
                    contactName: '',
                    contactPhone: '',
                    visitTime: '',
                    remark: '',
                    repairArea: '',
                    repairImage:[],
                    repairOrderId:'',
                    roomId:''
                },
                imageFileList: [],   // 新增：用于 el-upload 显示
                rules: {
                    contactName: [
                        { required: true, message: '请输入联系人', trigger: 'blur' },
                    ],
                    contactPhone: [
                        { required: true, message: '请输入联系电话', trigger: 'blur' }
                    ],
                    visitTime: [
                        { required: true, message: '请选择上门时间', trigger: 'blur' }
                    ],
                    repairArea: [
                        { required: true, message: '请选择报修区域', trigger: 'blur' }
                    ],
                    remark: [
                        { required: true, message: '请输入描述', trigger: 'blur' }
                    ],
                },

                dialogImageUrl: '',

                dialogVisible: false,
                selectedPath: [],          // 选中的路径，如 ['today', 0]
                cascaderOptions: [],       // 动态生成的选项
                cascaderProps: {
                    expandTrigger: 'click',
                    emitPath: true,
                    value: 'value',
                    label: 'label',
                    children: 'children',
                    disabled: 'disabled'
                },
                // 统一的时段列表（可根据需要增删）
                timeSlots: [
                    { range: '08:00-10:00', start: '08:00', end: '10:00' },
                    { range: '10:00-12:00', start: '10:00', end: '12:00' },
                    { range: '12:00-14:00', start: '12:00', end: '14:00' },
                    { range: '14:00-16:00', start: '14:00', end: '16:00' },
                    { range: '16:00-18:00', start: '16:00', end: '18:00' }
                ]
            } 
        },
        mounted() {
            // 初始化级联选项
            this.refreshCascaderOptions();
        },
        created(){
            this.initPage();
        },
        computed:{
            uploadHeaders() {
                const token = getToken()  // 从 Cookie 中读取 Admin-Token
                if (token) {
                    return {
                    Authorization: 'Bearer ' + token
                    }
                }
                return {}
            }
        },
        methods:{
            // 将后端返回的 visitTime 字符串转换为级联选择器的选中值
            setVisitTimeFromString(isoString) {
                if (!isoString) return;
                const targetDate = new Date(isoString);
                if (isNaN(targetDate.getTime())) return;

                // 获取今天、明天、后天的起始时间（00:00:00）
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                const tomorrow = new Date(today);
                tomorrow.setDate(today.getDate() + 1);
                const afterTomorrow = new Date(today);
                afterTomorrow.setDate(today.getDate() + 2);

                const targetDateStart = new Date(targetDate);
                targetDateStart.setHours(0, 0, 0, 0);

                let selectedDateValue = null;
                let selectedDateRaw = null;

                if (targetDateStart.getTime() === today.getTime()) {
                    selectedDateValue = 'today';
                    selectedDateRaw = today;
                } else if (targetDateStart.getTime() === tomorrow.getTime()) {
                    selectedDateValue = 'tomorrow';
                    selectedDateRaw = tomorrow;
                } else if (targetDateStart.getTime() === afterTomorrow.getTime()) {
                    selectedDateValue = 'afterTomorrow';
                    selectedDateRaw = afterTomorrow;
                } else {
                    // 超出三天范围，不回显（可根据业务扩展）
                    console.warn('上门时间超出三天范围，无法回显');
                    return;
                }

                // 获取时段索引（根据目标时间的小时+分钟）
                const targetHour = targetDate.getHours();
                const targetMinute = targetDate.getMinutes();
                const targetTotalMinutes = targetHour * 60 + targetMinute;

                let slotIndex = -1;
                for (let i = 0; i < this.timeSlots.length; i++) {
                    const slot = this.timeSlots[i];
                    const [startHour, startMinute] = slot.start.split(':').map(Number);
                    const [endHour, endMinute] = slot.end.split(':').map(Number);
                    const slotStart = startHour * 60 + startMinute;
                    const slotEnd = endHour * 60 + endMinute;
                    // 注意：时段是左闭右开 [start, end)，也可以根据业务调整
                    if (targetTotalMinutes >= slotStart && targetTotalMinutes < slotEnd) {
                        slotIndex = i;
                        break;
                    }
                }

                if (slotIndex === -1) {
                    console.warn('未找到匹配的时段');
                    return;
                }

                // 刷新级联选项（确保最新禁用状态）
                this.refreshCascaderOptions();

                // 设置选中值（需要等待 DOM 更新）
                this.$nextTick(() => {
                    this.selectedPath = [selectedDateValue, slotIndex];
                    // 手动触发 change 以同步 ruleForm.visitTime（可选，但建议）
                    this.handleCascaderChange(this.selectedPath);
                });
            },

            initPage(){
                this.formStatus = this.$route.query.status;
                if(this.formStatus == 'edit'){
                    this.repairOrderId = this.$route.query.repairOrderId;
                    this.getOrderDetail(this.repairOrderId);
                }
            },

            fixImageUrl(url) {
                if (!url) return '';
                if (url.includes('127.0.0.1:11345')) {
                    return url.replace('http://127.0.0.1:11345', 'http://mashang.eicp.vip:5555/ms_stu_pro345');
                }
                if (url.startsWith('/profile')) {
                    return `http://mashang.eicp.vip:5555/ms_stu_pro345${url}`;
                }
                return url;
            },

            //提交工单
            submitNewOrder() {
                if (this.formStatus == 'add') {
                    myOrderCreate(this.ruleForm).then(res => {
                        if (res.code == 200) {
                            this.$message.success(res.msg);
                            this.$router.push({ path: '/repairService/myRepair' });
                        } else {
                            this.$message.error(res.message);
                        }
                    }).catch(() => {});
                } else if (this.formStatus == 'edit') {
                    // 确保 repairOrderId 已设置
                    const updateData = {
                        ...this.ruleForm,
                        repairOrderId: this.repairOrderId   // 添加订单ID
                    };
                    myOrderUpdate(updateData).then(res => {
                        if (res.code == 200) {
                            this.$message.success(res.msg);
                            this.$router.push({ path: '/repairService/myRepair' });
                        } else {
                            this.$message.error(res.message);
                        }
                    }).catch(() => {});
                }
            },

            //关闭工单提交
            closeOrder(){
                this.$router.push({
                    path:'/repairService/myRepair'
                })
            },

            //查询工单详情
            getOrderDetail(repairOrderId) {
                orderDetail(repairOrderId).then(res => {
                    console.log(res);
                    
                    const detail = res.data;
                    this.ruleForm = { ...detail };
                    const images = detail.repairImage || [];
                    this.ruleForm.repairImage = images.map(url => this.fixImageUrl(url));
                    this.imageFileList = images.map((url, idx) => ({
                        uid: Date.now() + idx,
                        name: `img_${idx}`,
                        url: this.fixImageUrl(url)
                    }));
                    // 回显上门时间
                    if (this.ruleForm.visitTime) {
                        this.setVisitTimeFromString(this.ruleForm.visitTime);
                    }
                }).catch(() => {})
            },

            // ---------- 上门时间相关方法 ----------
            // 获取格式化日期 "M月D日"
            getFormattedDate(date) {
                const month = date.getMonth() + 1;
                const day = date.getDate();
                return `${month}月${day}日`;
            },

            // 获取星期几（用于显示，本处可选但保留扩展）
            getWeekDay(date) {
                const weekdays = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
                return weekdays[date.getDay()];
            },

            // 生成今天、明天、后天的日期节点（返回数组，每个节点包含原始Date对象、显示标签、唯一值）
            generateDateNodes() {
                const today = new Date();
                const tomorrow = new Date(today);
                tomorrow.setDate(today.getDate() + 1);
                const afterTomorrow = new Date(today);
                afterTomorrow.setDate(today.getDate() + 2);

                return [
                    { rawDate: today, label: `${this.getFormattedDate(today)}（今天）`, value: 'today' },
                    { rawDate: tomorrow, label: `${this.getFormattedDate(tomorrow)}（明天）`, value: 'tomorrow' },
                    { rawDate: afterTomorrow, label: `${this.getFormattedDate(afterTomorrow)}（后天）`, value: 'afterTomorrow' }
                ];
            },

            // 判断某个时段的结束时间是否已经过去（仅用于今天）
            isSlotExpired(rawDate, endTimeStr, currentNow) {
                const [hour, minute] = endTimeStr.split(':').map(Number);
                const slotEnd = new Date(rawDate);
                slotEnd.setHours(hour, minute, 0, 0);
                return slotEnd < currentNow;
            },

            // 构建级联选择器的 options（基于当前时间动态计算禁用状态）
            buildCascaderOptions() {
                const dateNodes = this.generateDateNodes();
                const currentNow = new Date(); // 实时当前时间
                const options = [];

                dateNodes.forEach(dateNode => {
                    const rawDate = dateNode.rawDate;
                    const isToday = dateNode.value === 'today';
                    // 构建该日期下的所有时段子选项
                    const children = this.timeSlots.map((slot, idx) => {
                        let disabled = false;
                        let expiredText = '';
                        if (isToday) {
                            // 仅今天需要判断时段是否已过（结束时间 < 当前时间）
                            const expired = this.isSlotExpired(rawDate, slot.end, currentNow);
                            if (expired) {
                                disabled = true;
                                expiredText = '时段已过';
                            }
                        }
                        // 明天/后天所有时段均可用（disabled = false）
                        const label = disabled ? `${slot.range}（${expiredText}）` : slot.range;
                        return {
                            value: idx,          // 使用索引作为二级节点的值
                            label: label,
                            disabled: disabled,
                            rawRange: slot.range,
                            startTime: slot.start,
                            endTime: slot.end
                        };
                    });
                    options.push({
                        value: dateNode.value,
                        label: dateNode.label,
                        rawDate: rawDate,
                        children: children
                    });
                });
                return options;
            },

            // 刷新级联选项（可在每次下拉面板打开时调用，保证时效性）
            refreshCascaderOptions() {
                this.cascaderOptions = this.buildCascaderOptions();
            },

            // 将选中的日期 + 时段开始时间转换为符合 date-time 的 ISO 字符串（带本地时区偏移）
            convertToDateTimeString(dateObj, startTime) {
                if (!dateObj || !startTime) return null;
                const [hour, minute] = startTime.split(':').map(Number);
                const dateTime = new Date(dateObj);
                dateTime.setHours(hour, minute, 0, 0);
                // 手动格式化为 YYYY-MM-DDTHH:mm:ss+08:00 格式
                const year = dateTime.getFullYear();
                const month = String(dateTime.getMonth() + 1).padStart(2, '0');
                const day = String(dateTime.getDate()).padStart(2, '0');
                const hours = String(dateTime.getHours()).padStart(2, '0');
                const minutes = String(dateTime.getMinutes()).padStart(2, '0');
                const offset = -dateTime.getTimezoneOffset();
                const sign = offset >= 0 ? '+' : '-';
                const absOffset = Math.abs(offset);
                const offsetHours = String(Math.floor(absOffset / 60)).padStart(2, '0');
                const offsetMinutes = String(absOffset % 60).padStart(2, '0');
                const timezone = `${sign}${offsetHours}:${offsetMinutes}`;
                return `${year}-${month}-${day}T${hours}:${minutes}:00${timezone}`;
            },

            // 级联选择器值变化时的处理
            handleCascaderChange(value) {
                // value 格式如 ['today', 0] 或 null
                if (!value || value.length < 2) {
                    this.ruleForm.visitTime = '';
                    // 触发表单校验
                    this.$refs.ruleForm.validateField('visitTime');
                    return;
                }
                const parentVal = value[0];
                const childIdx = value[1];
                // 查找对应的时段节点
                const parent = this.cascaderOptions.find(opt => opt.value === parentVal);
                if (!parent) {
                    this.resetTimeSelection();
                    return;
                }
                const child = parent.children[childIdx];
                if (!child || child.disabled) {
                    this.$message.warning('该时段已过期，请重新选择');
                    this.resetTimeSelection();
                    return;
                }
                // 生成符合格式的 date-time 字符串
                const dateTimeStr = this.convertToDateTimeString(parent.rawDate, child.startTime);
                this.ruleForm.visitTime = dateTimeStr;
                // 触发表单校验
                this.$refs.ruleForm.validateField('visitTime');
                this.$message.success(`已选择：${parent.label} ${child.rawRange}`);
            },

            // 级联选择器下拉面板显示/隐藏时的回调（显示时重新生成选项，保证禁用状态最新）
            handleCascaderVisibleChange(visible) {
                if (visible) {
                    this.refreshCascaderOptions();
                    // 如果之前有选中的值但可能已失效，清空并提示
                    if (this.selectedPath && this.selectedPath.length) {
                        const parentVal = this.selectedPath[0];
                        const childIdx = this.selectedPath[1];
                        const parent = this.cascaderOptions.find(opt => opt.value === parentVal);
                        if (parent && parent.children[childIdx] && parent.children[childIdx].disabled) {
                            this.$message.warning('您之前选择的时段已过期，请重新选择');
                            this.resetTimeSelection();
                        }
                    }
                }
            },

            // 重置时间选择
            resetTimeSelection() {
                this.selectedPath = [];
                this.ruleForm.visitTime = '';
                this.$refs.ruleForm.validateField('visitTime');
            },
            
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                if (valid) {
                    alert('submit!');
                } else {
                    console.log('error submit!!');
                    return false;
                }
                });
            },
            resetForm(formName) {
                this.$refs[formName].resetFields();
            },

            handleRemove(file, fileList) {
                this.imageFileList = fileList;
                this.ruleForm.repairImage = fileList.map(f => f.url).filter(url => url);
            },

            handleSuccess(response, file, fileList) {
                if (response.code === 200) {
                    let imageUrl = response.data || response.url;
                    if (!imageUrl) {
                        this.$message.error('上传响应缺少图片地址');
                        return;
                    }
                    // 修正 URL
                    imageUrl = this.fixImageUrl(imageUrl);
                    file.url = imageUrl;
                    this.ruleForm.repairImage.push(imageUrl);
                    this.imageFileList = fileList.map(f => {
                        if (!f.url && f.response) {
                            f.url = this.fixImageUrl(f.response.data || f.response.url);
                        }
                        return f;
                    });
                    this.$message.success('上传成功');
                } else if (response.code === 401) {
                    this.$message.error('认证失败，请重新登录');
                } else {
                    this.$message.error(response.msg || '上传失败');
                }
            },

            handlePictureCardPreview(file) {
                this.dialogImageUrl = file.url;
                console.log(this.dialogImageUrl);
                
                this.dialogVisible = true;
            }


        }
    }
</script>
<style lang="scss" scoped>
.add-repair-container{
    box-sizing: border-box;

    //标题样式
    .title{
        padding:20px 15px;
        font-weight: bold;
        background-color: white;
        font-size: 18px;
    }

    .add-repair-container{
        height: 100vh;
        padding: 20px;
        background-color: #f1f2f6;
        box-sizing: border-box;
        font-weight: normal;
        

        .add-repair-content{
            padding: 20px 150px;
            background-color: white;
            box-sizing: border-box;
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
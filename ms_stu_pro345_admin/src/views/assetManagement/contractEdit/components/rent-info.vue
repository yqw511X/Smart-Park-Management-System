<template>
    <div class="tenant-info-container">
        <!-- 表单 -->
        <div class="form">
            <el-form
                :model="rentInfoForm"
                size="mini"
                >
                <!-- 签订日期 -->
                <el-form-item label="签订日期：">
                    <el-date-picker
                        v-model="rentInfoForm.dateSign"
                        type="date"
                        placeholder="选择日期"
                        size="mini"
                        >
                    </el-date-picker>
                </el-form-item>

                <!-- 租赁日期 -->
                <el-form-item label="租赁期限：">
                    <el-date-picker
                        v-model="rentInfoForm.startOverTime"
                        type="daterange"
                        range-separator="至"
                        start-placeholder="开始日期"
                        end-placeholder="结束日期"
                        :unlink-panels="true"
                        @change="handleUnlinkChange"
                        size="mini"
                        >
                    </el-date-picker>
                </el-form-item>

                <!-- 快捷选择 -->
                <el-form-item label="快捷选择：">
                    <el-radio-group 
                        v-model="selectedYear" 
                        @change="handleQuickSelect"
                        :disabled="!hasStartDate"
                    >
                        <el-radio-button 
                            v-for="year in yearOptions" 
                            :key="year" 
                            :label="year"
                        >
                            {{ year }}年
                        </el-radio-button>
                    </el-radio-group>
                    <span v-if="!hasStartDate" class="hint">
                        （请先选择开始日期）
                    </span>
                </el-form-item>
            </el-form>
        </div>

        <!-- 表格 -->
        <div class="table-total-container">

            <span>固定租金</span>

            <div class="table-container">
                <!-- 标题 -->
                <div class="top-tip">
                    <div >
                        计算方式:按单元面积
                    </div>
                    <div>
                        租赁面积:{{area}}平米
                    </div>
                </div>

                <!-- 日租金单价 -->
                <div class="day_rent">
                    <el-form 
                        :inline="true" 
                        :model="rentInfoTable" 
                        class="demo-form-inline"
                        >
                        <!-- 租金单价 -->
                        <el-form-item 
                            prop="tenantUnitPrice"
                            label="租金单价："
                            class="item_gap"
                            >
                            <el-input
                                class="input_rent"
                                size="mini"
                                width="50"
                                v-model="rentInfoTable.tenantUnitPrice"
                                @change="calculateRent"
                                >
                            <el-select
                                slot="append"
                                placeholder="请选择"
                                class="select"
                                v-model="rentInfoTable.tenantType"
                                @change="calculateRent"
                                >
                                <el-option
                                    v-for="item in rentType"
                                    :label="item.title" 
                                    :value="item.index"
                                    >
                                </el-option>
                            </el-select>
                        </el-input>
                        </el-form-item>

                        <!-- 日租金 -->
                        <el-form-item 
                            label="日租金："
                            prop="dailyRent"
                            >
                            <el-input
                                class="input_day"
                                size="mini"
                                v-model="rentInfoTable.dailyRent"
                                >
                            </el-input>
                            
                        </el-form-item>

                        <!-- 日租金单位 -->
                        <el-form-item 
                            >
                           <span>元/天</span>
                        </el-form-item>
                    </el-form>
                    
                    
                </div>

                <!-- 月租金 -->
                <div class="month_rent">
                    <el-form 
                        :inline="true" 
                        :model="rentInfoTable" 
                        class="demo-form-inline"
                        >
                        <!-- 月租金计算方式 -->
                        <el-form-item 
                            prop="tenantMethod"
                            label="月租金计算方式："
                            class="item_month_rent_way_gap"
                            >
                            <el-radio 
                                v-model="rentInfoTable.tenantMethod" 
                                label="0"
                                @input="calculateRent"
                                >
                                按固定租金
                            </el-radio>
                            <el-radio 
                                v-model="rentInfoTable.tenantMethod" 
                                label="1"
                                @input="calculateRent"
                                >
                                按实际天数
                            </el-radio>
                        </el-form-item>

                        <!-- 月租金 -->
                        <el-form-item 
                            label="月租金："
                            class="item_month_rent"
                            prop="monthRent"
                            >
                            <div>
                                <el-input
                                class="input_month"
                                size="mini"
                                v-model="monthRent28" 
                                >
                                </el-input>
                                <span>元/28天</span>
                            </div>

                            <div>
                                <el-input
                                class="input_month"
                                size="mini"
                                v-model="rentInfoTable.monthRent" 
                                >
                                </el-input>
                                <span>元/30天</span>
                            </div>

                            <div>
                                <el-input
                                class="input_month"
                                size="mini"
                                v-model="monthRent31" 
                                >
                                </el-input>
                                <span>元/31天</span>
                            </div>
                        </el-form-item>                  
                    </el-form>                  
                </div>

                <!-- 管理费单价 -->
                <div class="manage_rent">
                    <el-form 
                        :inline="true" 
                        :model="rentInfoTable" 
                        class="demo-form-inline"
                        >
                        <!-- 管理费单价 -->
                        <el-form-item 
                            label="管理费单价："
                            class="item_gap"
                            prop="manageUnitPrice"
                            >
                            <el-input
                                class="input_rent"
                                size="mini"
                                width="50"
                                v-model="rentInfoTable.manageUnitPrice" 
                                @change="calculateManageFee"
                                >
                                <el-select
                                    slot="append"
                                    placeholder="请选择"
                                    class="select"
                                    v-model="rentInfoTable.manageMoneyType"
                                    @change="calculateManageFee"
                                    >
                                    <el-option
                                        v-for="item in rentType"
                                        :label="item.title" 
                                        :value="item.index"
                                        >
                                    </el-option>
                                </el-select>
                            </el-input>
                        </el-form-item>
                    </el-form>
                </div>

                <!-- 日月管理费 -->
                <div class="day_month_manage_rent">
                    <el-form 
                        :inline="true" 
                        :model="rentInfoTable" 
                        class="demo-form-inline"
                        >
                        <!-- 日管理费 -->
                        <el-form-item 
                            label="日管理费："
                            class="item_month_rent_way_gap"
                            >
                            <el-input
                                class="input_month"
                                size="mini"
                                v-model="rentInfoTable.dailyFee" 
                                >
                            </el-input>
                            <span>元/天</span>
                        </el-form-item>

                        <!-- 月管理费 -->
                        <el-form-item 
                            label="月管理费："
                            class="item_month_rent"
                            prop="monthFee"
                            >
                            <div>
                                <el-input
                                class="input_month"
                                size="mini"
                                v-model="monthFee28" 
                                >
                                </el-input>
                                <span>元/28天</span>
                            </div>

                            <div>
                                <el-input
                                class="input_month"
                                size="mini"
                                v-model="rentInfoTable.monthFee" 
                                >
                                </el-input>
                                <span>元/30天</span>
                            </div>

                            <div>
                                <el-input
                                class="input_month"
                                size="mini"
                                v-model="monthFee31" 
                                >
                                </el-input>
                                <span>元/31天</span>
                            </div>
                        </el-form-item>                  
                    </el-form>                  
                </div>

                <!-- 押付方式 -->
                <div class="pay_way">
                    <el-form 
                        :inline="true" 
                        :model="rentInfoTable" 
                        class="demo-form-inline"
                        >
                        <!-- 押付方式 -->
                        <el-form-item 
                            label="押付方式："
                            class="item_gap"
                            >
                            <div>
                                <span class="pay_way_span">押</span>
                                <!-- 抵押月数 -->
                                <el-input
                                    class="input_rent"
                                    size="mini"
                                    width="50"
                                    v-model="rentInfoTable.mortgageMonth" 
                                >
                                </el-input>
                                <span>
                                    月
                                </span>
                                <!-- 当次抵押支付 -->
                                <el-input
                                    class="input_rent"
                                    size="mini"
                                    width="50"
                                    v-model="rentInfoTable.mortgagePay" 
                                    >
                                </el-input>
                                <span>
                                    元
                                </span>
                            </div>
                            
                        </el-form-item>
                    </el-form>
                </div>
            </div>
        </div>

        <!-- 底部栏 -->
        <div class="foot">
            <el-button
                size="mini"
                @click="toContractManage"
                >
                返回
            </el-button>

            <el-button 
                type="primary"
                size="mini"
                @click="sendDataToParent"
                >
                保存
            </el-button>
            <el-button
                size="mini"
                @click="sendDataToParent2"
                >
                上一步
            </el-button>
        </div>
        
    </div>
</template>

<script>
import dayjs from 'dayjs'
import { addContract,contractChange,contractUpdata } from '../../../../api/asset/contract';
export default{
    dicts:['rent_type'],
    name:'rent-info',
    props: {
        area: Number,
        dateSign:String,
        startOverTime:Array,
        tenantUnitPrice:Number,
        tenantType:String,
        manageUnitPrice:Number,
        manageMoneyType:String,
        mortgagePay:Number,
        mortgageMonth:Number,
        tenantMethod:String,
        status:String,
        tenantInfo:Object,
    },
    data(){
        return{
            rentType:[
                {title:'元/m²/天',index:'0'},
                {title:'元/m²/月',index:'1'}
            ],//租金类型
            rentInfoForm:{
                dateSign:'',//签订日期
                startOverTime:[],//起始日期
            },//表单用数据
            selectedYear: undefined, // 选中的年限
            yearOptions: [1, 2, 3, 4, 5],  // 可选年限
            rentInfoTable:{
                tenantUnitPrice:undefined,//租金单价
                tenantType:'',//租金类型
                dailyRent:undefined,//日租金
                tenantMethod:'',//租金收租方式
                monthRent:undefined,//月租金
                manageUnitPrice:undefined,//管理费单价
                manageMoneyType:'',//管理费类型
                dailyFee:undefined,//日管理费
                monthFee:undefined,//月管理费
                manageMoney:undefined,//管理费
                mortgageMonth:undefined,//抵押月数
                mortgagePay:undefined,//当次抵押支付
            },//租金表格数据
            monthRent28:undefined,
            monthRent31:undefined,
            monthFee28:undefined,
            monthFee31:undefined,
        }
    },
    watch:{
        //签订日期
        dateSign: {
            handler(newVal, oldVal) {
                if (newVal) {  // 添加非空判断
                    this.$set(this.rentInfoForm, 'dateSign', newVal);
                }
            },
            immediate: true  // 立即执行一次
        },
        //开始时间
        startOverTime: {
            handler(newVal, oldVal) {
                if (newVal) {  // 添加非空判断
                    this.$set(this.rentInfoForm, 'startOverTime', newVal);
                }
            },
            immediate: true  // 立即执行一次
        },
        //租金单价
        tenantUnitPrice: {
            handler(newVal, oldVal) {
                if (newVal) {  // 添加非空判断
                    this.$set(this.rentInfoTable, 'tenantUnitPrice', newVal);
                    this.calculateRent();
                }
            },
            immediate: true  // 立即执行一次
        },
        //租金类型
        tenantType: {
            handler(newVal, oldVal) {
                if (newVal) {  // 添加非空判断
                    this.$set(this.rentInfoTable, 'tenantType', newVal);
                    this.calculateRent();
                }
            },
            immediate: true  // 立即执行一次
        },
        //租金计算类型
        tenantMethod: {
            handler(newVal, oldVal) {
                if (newVal) {  // 添加非空判断
                    this.$set(this.rentInfoTable, 'tenantMethod', newVal);
                    this.calculateRent();
                }
            },
            immediate: true  // 立即执行一次
        },
        //管理费单价
        manageUnitPrice: {
            handler(newVal, oldVal) {
                if (newVal) {  // 添加非空判断
                    this.$set(this.rentInfoTable, 'manageUnitPrice', newVal);
                    this.calculateManageFee();
                }
            },
            immediate: true  // 立即执行一次
        },
        //管理费类型
        manageMoneyType: {
            handler(newVal, oldVal) {
                if (newVal) {  // 添加非空判断
                    this.$set(this.rentInfoTable, 'manageMoneyType', newVal);
                    this.calculateManageFee();
                }
            },
            immediate: true  // 立即执行一次
        },
        //押付租金
        mortgagePay: {
            handler(newVal, oldVal) {
                if (newVal) {  // 添加非空判断
                    this.$set(this.rentInfoTable, 'mortgagePay', newVal);
                }
            },
            immediate: true  // 立即执行一次
        },
        //押付月数
        mortgageMonth: {
            handler(newVal, oldVal) {
                if (newVal) {  // 添加非空判断
                    this.$set(this.rentInfoTable, 'mortgageMonth', newVal);
                }
            },
            immediate: true  // 立即执行一次
        }
    },
    computed: {
        // 判断是否有开始日期
        hasStartDate() {
            return this.rentInfoForm.startOverTime && 
                    this.rentInfoForm.startOverTime.length > 0 &&
                    this.rentInfoForm.startOverTime[0]
        },
        
        // 获取开始日期
        startDate() {
            return this.hasStartDate ? this.rentInfoForm.startOverTime[0] : null
        },

    },
    methods:{
        //向父组件传递信息
        sendDataToParent() {
            const formattedDates = this.rentInfoForm.startOverTime.map(date => 
                dayjs(date).format('YYYY-MM-DD HH:mm:ss')
            );
            const dateSign = dayjs(this.rentInfoForm.dateSign).format('YYYY-MM-DD HH:mm:ss')
            const startOverTime={
                dateSign:dateSign,
                startTime:formattedDates[0],
                overTime:formattedDates[1],
            }
            
            const totalInfo={...this.tenantInfo,...this.rentInfoTable,...startOverTime};
            console.log(totalInfo);
            
            switch(this.status) {
                case 'add':
                    addContract(totalInfo).then(res=>{
                        console.log('新增合同反馈',res);
                        if(res.status==200){
                            window.scrollTo({
                                top: 0,
                                behavior: 'smooth' // 平滑滚动
                            });
                            const data = {
                                active:2
                            };
                            this.$emit('rent-event', data);
                        }else{
                            this.$message.error(res.message);
                        }
                    }).catch(()=>{

                    })
                    break;
                case 'change':
                    contractChange(totalInfo).then(res=>{
                        console.log('变更合同反馈',res);
                        if(res.status==200){
                            window.scrollTo({
                                top: 0,
                                behavior: 'smooth' // 平滑滚动
                            });
                            const data = {
                                active:2
                            };
                            this.$emit('rent-event', data);
                        }else{
                            this.$message.error(res.message);
                        }
                    }).catch(()=>{

                    })
                    break;
                case 'edit':
                    contractUpdata(totalInfo).then(res=>{
                        console.log('变更编辑反馈',res);
                        if(res.status==200){
                            window.scrollTo({
                                top: 0,
                                behavior: 'smooth' // 平滑滚动
                            });
                            const data = {
                                active:2
                            };
                            this.$emit('rent-event', data);
                        }else{
                            this.$message.error(res.message);
                        }
                    }).catch(()=>{

                    })
                    break;
                default:
            }            
        },

        //向父组件传递信息2
        sendDataToParent2(){
            
            const data = {
                active:0
            };

            window.scrollTo({
                top: 0,
                behavior: 'smooth' // 平滑滚动
            });

            this.$emit('rent-event', data);
        },

        //选择租赁起始日期变化
        handleUnlinkChange(val){
            this.selectedYear = null;
        },

        // 快捷选择处理
        handleQuickSelect() {
            if (!this.hasStartDate) {
                this.$message.warning('请先选择开始日期')
                this.selectedYear = ''  // 清空选中
                return
            }
            
            // 计算结束日期
            const start = dayjs(this.startDate)
            const end = start.add(this.selectedYear, 'year').subtract(1, 'day')  // 减一天，保证整年
            
            // 更新日期范围
            this.rentInfoForm.startOverTime = [
                this.startDate,
                end.toDate()
            ]
        },

        //自动计算租金
        calculateRent(){
            // 1. 更健壮的空值判断
            if (this.rentInfoTable.tenantUnitPrice === undefined || 
                this.rentInfoTable.tenantUnitPrice === null || 
                this.rentInfoTable.tenantUnitPrice === '') {
                return;
            }
            
            // 2. 检查计算类型是否已选择
            if (this.rentInfoTable.tenantType === undefined || 
                this.rentInfoTable.tenantType === null || 
                this.rentInfoTable.tenantType === '') {
                return;
            }

            // 3. 确保面积存在（从props传入）
            if (!this.area || this.area <= 0) {
                return;
            }

             // 4. 将单价转换为数字（输入框的值可能是字符串）
            const price = Number(this.rentInfoTable.tenantUnitPrice);
            const area = Number(this.area);
            
            if (isNaN(price) || price <= 0) {
                return;
            }

            // 5. 根据类型计算
            // rentType: 0=元/平方米/天, 1=元/平方米/月
            switch(this.rentInfoTable.tenantType) {
                case '0': // 元/平方米/天
                    // 日租金 = 单价 × 面积
                    this.rentInfoTable.dailyRent = (price * area).toFixed(2);
                    break;
                    
                case '1': // 元/平方米/月
                    // 月租金 = 单价 × 面积
                    this.rentInfoTable.dailyRent = (price * area / 30).toFixed(2);
                    break;
                    
                default:
            }

            // 6. 检查月租金计算方式是否已选择
            if (this.rentInfoTable.tenantMethod === undefined || 
                this.rentInfoTable.tenantMethod === null || 
                this.rentInfoTable.tenantMethod === '') {
                return;
            }

            // 7. 根据租金计算方式
            // 租金收租方法（0固定资金，1按日收）
            //0-0
            if(this.rentInfoTable.tenantType == '0' && this.rentInfoTable.tenantMethod == '0'){
                this.rentInfoTable.monthRent = (price * area * 30).toFixed(2);
                this.monthRent31 = (price * area * 30).toFixed(2);
                this.monthRent28 = (price * area * 30).toFixed(2);
            }else if(this.rentInfoTable.tenantType == '0' && this.rentInfoTable.tenantMethod == '1'){
                this.rentInfoTable.monthRent = (price * area * 30).toFixed(2);
                this.monthRent31 = (price * area * 31).toFixed(2);
                this.monthRent28 = (price * area * 28).toFixed(2);
            }else if(this.rentInfoTable.tenantType == '1' && this.rentInfoTable.tenantMethod == '0'){
                this.rentInfoTable.monthRent = (price * area).toFixed(2);
                this.monthRent31 = (price * area).toFixed(2);
                this.monthRent28 = (price * area).toFixed(2);
            }else if(this.rentInfoTable.tenantType == '1' && this.rentInfoTable.tenantMethod == '1'){
                this.rentInfoTable.monthRent = (price * area).toFixed(2);
                this.monthRent31 = (price * area /30 * 31).toFixed(2);
                this.monthRent28 = (price * area /30 * 28).toFixed(2);
            }
        },

         //自动计算管理费值
        calculateManageFee(){
            // 1. 更健壮的空值判断
            if (this.rentInfoTable.manageUnitPrice === undefined || 
                this.rentInfoTable.manageUnitPrice === null || 
                this.rentInfoTable.manageUnitPrice === '') {
                return;
            }
              
            // 2. 检查管理费类型是否已选择
            if (this.rentInfoTable.manageMoneyType === undefined || 
                this.rentInfoTable.manageMoneyType === null || 
                this.rentInfoTable.manageMoneyType === '') {
                return;
            }

            // 3. 确保面积存在（从props传入）
            if (!this.area || this.area <= 0) {
                return;
            }

             // 4. 将单价转换为数字（输入框的值可能是字符串）
            const price = Number(this.rentInfoTable.manageUnitPrice);
            const area = Number(this.area);
            
            if (isNaN(price) || price <= 0) {
                return;
            }

            // 5. 根据类型计算
            // rentType: 0=元/平方米/天, 1=元/平方米/月
            switch(this.rentInfoTable.manageMoneyType) {
                case '0': // 元/平方米/天
                    // 日租金 = 单价 × 面积
                    this.rentInfoTable.dailyFee = (price * area).toFixed(2);
                    this.rentInfoTable.monthFee = (price * area * 30).toFixed(2);
                    this.monthFee28 = (price * area * 28).toFixed(2);
                    this.monthFee31 = (price * area * 31).toFixed(2);
                    break;
                    
                case '1': // 元/平方米/月
                    // 月租金 = 单价 × 面积
                    this.rentInfoTable.dailyFee = (price * area /30).toFixed(2);
                    this.rentInfoTable.monthFee = (price * area).toFixed(2);

                    break;
                    
                default:
            }

            // 6. 检查月租金计算方式是否已选择
            if (this.rentInfoTable.tenantMethod === undefined || 
                this.rentInfoTable.tenantMethod === null || 
                this.rentInfoTable.tenantMethod === '') {
                return;
            }

            // 7. 根据租金计算方式
            // 租金收租方法（0固定资金，1按日收）
            //0-0
            if(this.rentInfoTable.tenantType == '0' && this.rentInfoTable.tenantMethod == '0'){
                this.rentInfoTable.monthRent = (price * area * 30).toFixed(2);
                this.monthRent31 = (price * area * 30).toFixed(2);
                this.monthRent28 = (price * area * 30).toFixed(2);
            }else if(this.rentInfoTable.tenantType == '0' && this.rentInfoTable.tenantMethod == '1'){
                this.rentInfoTable.monthRent = (price * area * 30).toFixed(2);
                this.monthRent31 = (price * area * 31).toFixed(2);
                this.monthRent28 = (price * area * 28).toFixed(2);
            }else if(this.rentInfoTable.tenantType == '1' && this.rentInfoTable.tenantMethod == '0'){
                this.rentInfoTable.monthRent = (price * area).toFixed(2);
                this.monthRent31 = (price * area).toFixed(2);
                this.monthRent28 = (price * area).toFixed(2);
            }else if(this.rentInfoTable.tenantType == '1' && this.rentInfoTable.tenantMethod == '1'){
                this.rentInfoTable.monthRent = (price * area).toFixed(2);
                this.monthRent31 = (price * area /30 * 31).toFixed(2);
                this.monthRent28 = (price * area /30 * 28).toFixed(2);
            }
        },

        //去合同界面
        toContractManage(){
            this.$router.push({
                path:'/assetManagement/contract'
            })
        }
    },
}
</script>

<style lang="scss" scoped>
.tenant-info-container{
    .form{
        margin: 0 200px;
    }

    .table-total-container{
        margin-bottom: 20px;
        .table-container{
            width: 800px;
            margin: auto;
            border: 1px solid #e5e5e5;

            //标题
            .top-tip{
                display: flex;
                justify-content: center;
                gap: 20px;
                align-items: center;
                height: 60px;
                background: linear-gradient(90deg, #fcfcfc 0%, #ebebeb 100%);
            }

            //日租金-单价
            .day_rent{
                display: flex;
                justify-content: center;
                align-items: center;
                border-top: 1px solid #e5e5e5;
                border-bottom: 1px solid #e5e5e5;
                padding-top: 20px;
                box-sizing: border-box;

                //单价
                .unit-price{
                    flex:1;
                }

                //日租金
                .rent-day{
                    flex:1;
                    display: flex;
                }

                .item_gap{
                    box-sizing: border-box;
                    margin-right: 100px;

                    .input_rent{
                        width: 200px;
                    }
                }

                .input_day{
                    width: 100px;
                }
               
            }

            //月租金
            .month_rent{
                display: flex;
                justify-content: center;
                align-items: center;
                border-bottom: 1px solid #e5e5e5;
                padding-top: 20px;
                box-sizing: border-box;
                //单价
                .unit-price{
                    flex:1;
                }
                //日租金
                .rent-day{
                    flex:1;
                    display: flex;
                }

                .item_month_rent_way_gap{
                    margin-right: 54px;

                    .input_rent{
                        width: 190px;
                    }
                }

                .input_month{
                    width: 100px;
                    margin-right: 10px;
                }
            }

            //管理费
            .manage_rent{
                display: flex;
                justify-content: center;
                align-items: center;
                border-bottom: 1px solid #e5e5e5;
                padding-top: 10px;
                box-sizing: border-box;
                //单价
                .unit-price{
                    flex:1;
                }
                //日租金
                .rent-day{
                    flex:1;
                    display: flex;
                }

                .input_rent{
                    width: 200px;
                }
             

                .input_day{
                    width: 100px;
                }
               
            }

            //日管理费/月管理费
            .day_month_manage_rent{
                display: flex;
                justify-content: center;
                align-items: center;
                border-bottom: 1px solid #e5e5e5;
                padding-top: 20px;
                box-sizing: border-box;
                //单价
                .unit-price{
                    flex:1;
                }
                //日租金
                .rent-day{
                    flex:1;
                    display: flex;
                }

                .item_month_rent_way_gap{
                    margin-right: 175px;

                    .input_rent{
                        width: 190px;
                    }
                }

                .input_month{
                    width: 100px;
                    margin-right: 10px;
                }
            }

            //押付方式
            .pay_way{
                display: flex;
                justify-content: center;
                align-items: center;
                padding-top: 10px;
                box-sizing: border-box;
                .pay_way_span{
                    margin-right: 5px;
                }
                //单价
                .unit-price{
                    flex:1;
                }
                //日租金
                .rent-day{
                    flex:1;
                    display: flex;
                }

                .input_rent{
                    width: 80px;
                }
             

                .input_day{
                    width: 100px;
                }
               
            }

        }

        
    }

    .foot{
            display: flex;
            justify-content: center;
    }
}
.select{
    width: 100px;
}

</style>
Vue.component('multiselect', window.VueMultiselect.default);
Vue.component('date-picker', window.DatePicker.default);
Vue.component('modal', window['vue-js-modal'].default);
Vue.config.devtools = true;


Vue.component('btcl-datepicker', {
	template: `
		<date-picker v-model="dateValue" format="dd-MM-yyyy" width=100% lang="en"></date-picker>
	`,
	props: ['date'],
	computed: {
		dateValue: {
			get() {
				return new Date(this.date);
			},
			set(val) {
				this.$emit('update:date', new Date(val).getTime());
			}
		}
	}
});


Vue.component('btcl-grid', {
	template: `
		<div :style="columnClass">
			<slot></slot>
		</div>
	`,
	props: ['column'],
	computed: {
		columnClass: function(){
			temp= "display:grid; padding:10px; grid-gap:10px; grid-template-columns:";
			for(i=0;i<parseInt(this.column);i++){
				temp += "auto ";
			}
			return temp+";";
		}
	}
});

Vue.component('btcl-field', {
	template: `
		<div class="form-group">
			<div v-if="vertical==='true'">
                <label class="control-label">{{title}}<span v-if=required class=required aria-required=true>*</span></label>
                <slot></slot>
            </div>
			<div v-else class=row>
				<label class="col-sm-4 control-label">{{title}}<span v-if=required class=required aria-required=true>*</span></label>
				<div v-if=bare><slot></slot></div>
				<div v-else class=col-sm-6><slot></slot></div>
			</div>
		</div>
	`,
	props: {
		title: String, 
		required: Boolean, 
		vertical: Boolean,
		bare: Boolean
	}
});

Vue.component('btcl-info', {
	template: `
		<div class="form-group">
			<div class=row>
				<label class="col-sm-4 control-label">{{title}}</label>
				<div class=col-sm-6>
					<p class="form-control" v-if="date">{{new Date(text).toLocaleDateString("ca-ES")}}</p>
					<p class="form-control" v-else>{{text}}</p>
				</div>
			</div>
		</div>
	`,
	props: {
		title: String,
		text: Object,
		date: Boolean,
		mountCallback: Object,
	},
	mounted() {
		this.$emit('loaded');

	}
});



Vue.component('btcl-input', {
	template: `
		<div class="form-group">
			<div v-if="vertical">
                <label class="control-label">{{title}}<span v-if=required class=required aria-required=true>*</span></label>
                <input type=text class="form-control" v-model="textValue" />
            </div>
			<div v-else class=row>
				<label class="col-sm-4 control-label">{{title}}<span v-if=required class=required aria-required=true>*</span></label>
				<div class=col-sm-6>
					<input v-if="readonly" type=text class="form-control" v-model="textValue" readonly/>
					<input v-else type=text class="form-control" v-model="textValue"/>
				</div>
			</div>
		</div>
	`,
	props: {
		title: String, 
		required: Boolean, 
		vertical: Boolean, 
		text: String,
		readonly : Boolean
	},
	computed: {
		textValue: {
			get() {
	        	return this.text;
	        },
	        set(val) {
	        	this.$emit('update:text', val);
	        }
		}
	}
});

Vue.component('btcl-form', {
	template: `
		<form :action="this.action" @submit.prevent="submit">
            <slot></slot>
        	<div style="padding-top:30px;">
            	<button type="submit" class="btn green-haze btn-block btn-lg">Submit</button>
            </div>
        </form>
	`,
	props: ['action', 'name', 'formData', 'redirect'],
	data: function(){
		return {
			submittedData: {}
		}
	},
	methods: {
		submit: function(event){
			this.name.forEach(function(value, index, array){
				this.submittedData[value] = this.formData[index];
			}, this);
			axios.post(event.target.action, this.submittedData)
			.then(result => {
				if(typeof this.redirect !== 'undefined'){
					this.redirect(result);
				}else {
					if(result.data.responseCode == 2) {
						toastr.error(result.data.msg);
					}else if(result.data.responseCode == 1){
						toastr.success("Your request has been processed", "Success");
					}
					else{
						toastr.error("Your request was not accepted", "Failure");
					}
				}
			})
			.catch(function (error) {
			});
		}
	}
});

Vue.component('btcl-portlet', {
	template: `
		<div class="portlet light bordered">
			<div v-if="title!==undefined"class="portlet-title">
				<div class="caption"><span class="caption-subject">{{title}}</span></div>
				<div class="tools"><a href="" class="collapse" data-original-title="" title=""></a></div>
			</div>
			
            <div class="portlet-body">
            	<slot></slot>
            </div>
		</div>
	`,
	props: ['title']
});


Vue.component('btcl-body', {
	
	template: `
		<div class="portlet light bordered">
			<div class="portlet-title">
				<div class="caption font-green-sharp">
					<span class="caption-subject bold uppercase">{{title}}</span>
					<span class="caption-helper">{{subtitle}}</span>
				</div>
		                                    
				<div class="actions">
					<!--<a href="javascript:;" class="btn btn-circle btn-default btn-sm"><i class="fa fa-pencil"></i> Edit </a>-->
					<a class="btn btn-circle btn-icon-only btn-default fullscreen" href="javascript:;"> </a>
				</div>
			</div>
		                                
			<div class="portlet-body">
				<div class=form-horizontal>
					<div class=form-body>
						<slot></slot>
					</div>
				</div>
			</div>
		</div>
		
	`,
	data: function(){
		return {
		}
	},
	props: ['title', 'subtitle'],
});

Vue.component('lli-client-search', {
	template:`
			<div>
			<p v-if=this.clientFlag class=form-control>{{clientObject.label}}</p>
			<multiselect v-else v-model="clientObject" :options="this.clientList" 
	        	:track-by=ID label=label :allow-empty="false" :searchable=true :loading=this.isLoading
	        	id=ajax :internal-search=false :options-limit="500" :limit="15" 
	    		@search-change="searchClient" open-direction="bottom" @select="selectClient">
	        </multiselect>
	        </div>
	`,
	props: ['client', 'callback'],
	data: function(){
		return {
			isLoading: false,
			clientList: [],
			clientFlag: true
		}
	},
	computed: {
		clientObject: {
			get() {
	        	return this.client;
	        },
	        set(val) {
	        	this.$emit('update:client', val);
	        }
		}
	},
	methods: {
		searchClient: function(query){
			isLoading = true;
			axios({ method: 'GET', 'url': context + 'lli/client/get-client.do?val=' + query})
			.then(result => {
				this.clientList = result.data.payload;
				isLoading = false;
    		}, error => {
    		});
		},
		selectClient: function(selectedOption){
			if(typeof this.callback !== "undefined"){
				this.callback(selectedOption.ID);
			}
		}
	},
	mounted() {
		this.clientFlag = isClientLoggedIn;
		if(this.clientFlag){
			this.clientObject = loggedInAccount;
			this.selectClient(loggedInAccount);
		}
	}
});

Vue.component('btcl-autocomplete', {
	template:`
		<multiselect v-model="autocompleteObject" :options="this.list" 
        	:track-by=ID label=label :allow-empty="false" :searchable=true :loading=this.isLoading
        	id=ajax :internal-search=false :options-limit="500" :limit="15" 
    		@search-change="searchObject" open-direction="bottom" @select="callback">
        </multiselect>
	`,
	props: ['model', 'url', 'selectcallback'],
	data: function(){
		return {
			isLoading: false,
			list: [],
		}
	},
	computed: {
		autocompleteObject: {
			get() {
	        	return this.model;
	        },
	        set(val) {
	        	this.$emit('update:model', val);
	        }
		}
	},
	methods: {
		searchObject: function(query){
			isLoading = true;
			axios({ method: 'GET', 'url': context + this.url + '?val=' + query})
			.then(result => {
				this.list = result.data.payload;
				isLoading = false;
    		}, error => {
    		});
		},
		callback: function(selectedOption, id){
			if(typeof this.selectcallback !== "undefined"){
				this.selectcallback(selectedOption.ID);
			}
		}
	}
});

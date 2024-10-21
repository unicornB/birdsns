define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'circle/circle/index' + location.search,
                    add_url: 'circle/circle/add',
                    edit_url: 'circle/circle/edit',
                    del_url: 'circle/circle/del',
                    multi_url: 'circle/circle/multi',
                    import_url: 'circle/circle/import',
                    table: 'circle',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'weigh',
                fixedColumns: true,
                fixedRightNumber: 1,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'pid', title: __('Pid')},
                        {field: 'title', title: __('Title'), operate: 'LIKE'},
                        {field: 'titlesub', title: __('Titlesub'), operate: 'LIKE'},
                        {field: 'iconimage', title: __('Iconimage'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'weigh', title: __('Weigh'), operate: false},
                        {field: 'status', title: __('Status'), searchList: {"0":__('Status 0'),"1":__('Status 1'),"2":__('Status 2')}, formatter: Table.api.formatter.status},
                        {field: 'user_id', title: __('User_id')},
                        {field: 'bannerimage', title: __('Bannerimage'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'follow_num', title: __('Follow_num')},
                        {field: 'recswitch', title: __('Recswitch'), searchList: {"1":__('Yes'),"0":__('No')}, table: table, formatter: Table.api.formatter.toggle},
                        {field: 'zan_num', title: __('Zan_num')},
                        {field: 'post_num', title: __('Post_num')},
                        {field: 'hotswitch', title: __('Hotswitch'), searchList: {"1":__('Yes'),"0":__('No')}, table: table, formatter: Table.api.formatter.toggle},
                        {field: 'payswitch', title: __('Payswitch'), searchList: {"1":__('Yes'),"0":__('No')}, table: table, formatter: Table.api.formatter.toggle},
                        {field: 'bg', title: __('Bg'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'desc', title: __('Desc'), operate: 'LIKE', table: table, class: 'autocontent', formatter: Table.api.formatter.content},
                        {field: 'privpostdata', title: __('Privpostdata'), searchList: {"everyone":__('Everyone'),"admin":__('Admin')}, formatter: Table.api.formatter.normal},
                        {field: 'privcomdata', title: __('Privcomdata'), searchList: {"everyone":__('Everyone'),"forbid":__('Forbid')}, formatter: Table.api.formatter.normal},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});

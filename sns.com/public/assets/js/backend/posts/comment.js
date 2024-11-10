define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'posts/comment/index' + location.search,
                    add_url: 'posts/comment/add',
                    edit_url: 'posts/comment/edit',
                    del_url: 'posts/comment/del',
                    multi_url: 'posts/comment/multi',
                    import_url: 'posts/comment/import',
                    table: 'posts_comment',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                fixedColumns: true,
                fixedRightNumber: 1,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'posts_id', title: __('Posts_id')},
                        {field: 'user_id', title: __('User_id')},
                        {field: 'fa_user_id', title: __('Fa_user_id')},
                        {field: 'content', title: __('Content'), operate: 'LIKE'},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'like_num', title: __('Like_num')},
                        {field: 'pid', title: __('Pid')},
                        {field: 'to_name', title: __('To_name'), operate: 'LIKE'},
                        {field: 'topswitch', title: __('Topswitch'), table: table, formatter: Table.api.formatter.toggle},
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

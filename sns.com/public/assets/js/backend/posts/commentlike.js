define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'posts/commentlike/index' + location.search,
                    add_url: 'posts/commentlike/add',
                    edit_url: 'posts/commentlike/edit',
                    del_url: 'posts/commentlike/del',
                    multi_url: 'posts/commentlike/multi',
                    import_url: 'posts/commentlike/import',
                    table: 'posts_comment_like',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'posts_comment_id', title: __('Posts_comment_id')},
                        {field: 'user_id', title: __('User_id')},
                        {field: 'fa_user_id', title: __('Fa_user_id')},
                        {field: 'posts_id', title: __('Posts_id')},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
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
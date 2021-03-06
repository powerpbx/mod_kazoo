{% if m.kazoo[{ui_element_opened element="ap_groups_widget_opened"}] %}
<table id="admin_portal_groups_table" class="table display table-striped table-condensed">
  <thead>
    <tr>
      <th style="text-align: center1;">{_ Group Name _}</th>
      <th style="text-align: center;">{_ Endpoints amount _}</th>
      <th style="text-align: center;"></th>
      <th style="text-align: center;"></th>
    </tr>
  </thead>
  <tbody>
    {% for group in m.kazoo.kz_list_account_groups %}
      <tr>
        <td style="text-align: center1;">{{ group[1]["name"] }}</td>
        <td style="text-align: center;">{{ group[1]["endpoints"] }}</td>
        <td style="text-align: center;">
          <i id="edit_{{ group[1]["id"] }}" class="fa fa-edit pointer" title="{_ Edit _}"></i>
        </td>
        {% wire id="edit_"++group[1]["id"]
                action={dialog_open title=_"Edit group "++group[1]["name"]
                                    template="_edit_group_lazy.tpl"
                                    group_id=group[1]["id"]
                       }
        %}
        <td style="text-align: center;">
          <i id="delete_{{ group[1]["id"] }}"
             class="fa fa-trash-o pointer"
             title="{_ Delete _}"></i>
        </td>
        {% wire id="delete_"++group[1]["id"]
                action={confirm text=_"Do you really want to delete group "++group[1]["name"]++"?"
                            action={postback postback={delete_group group_id=group[1]["id"]}
                                             delegate="mod_kazoo"
                                   }
                       }
        %}
      </tr>
    {% endfor %}
  </tbody>
</table>

{% javascript %}
var oTable = $('#admin_portal_groups_table').dataTable({
"pagingType": "simple",
"bFilter" : true,
"aaSorting": [[ 0, "desc" ]],
"aLengthMenu" : [[5, 15, -1], [5, 15, "All"]],
"iDisplayLength" : 5,
"oLanguage" : {
        "sInfoThousands" : " ",
        "sLengthMenu" : "_MENU_ {_ lines per page _}",
        "sSearch" : "{_ Filter _}:",
        "sZeroRecords" : "{_ Nothing found, sorry _}",
        "sInfo" : "{_ Showing _} _START_ {_ to _} _END_ {_ of _} _TOTAL_ {_ entries _}",
        "sInfoEmpty" : "{_ Showing 0 entries _}",
        "sInfoFiltered" : "({_ Filtered from _} _MAX_ {_ entries _})",
        "oPaginate" : {
                "sPrevious" : "{_ Back _}",
                "sNext" : "{_ Forward _}"
        }
},
"columnDefs": [
],

});
{% endjavascript %}
{% endif %}

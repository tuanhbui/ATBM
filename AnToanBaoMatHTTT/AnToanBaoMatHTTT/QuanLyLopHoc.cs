using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Web;
using Oracle.ManagedDataAccess.Client;
using Oracle.ManagedDataAccess.Types;

namespace QLLH
{
    public partial class QuanLyLopHoc : Form
    {
        public QuanLyLopHoc()
        {
            InitializeComponent();
            LOP.Enabled = false;
            LOPthu.Enabled = false;
   
        }

        private void DanhSachUser()
        {
            OracleConnection con_ds = new OracleConnection();
            con_ds.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            DataSet dataSet_ds = new DataSet();
            OracleCommand cmd_ds;
            if (timkiemuserroletb.Text == "")
                cmd_ds = new OracleCommand("Select * from all_users", con_ds);
            else
                cmd_ds = new OracleCommand("Select * from all_users where username = '" + timkiemuserroletb.Text.ToUpper() + "'", con_ds);
            cmd_ds.CommandType = CommandType.Text;
            con_ds.Open();
            using (OracleDataReader reader = cmd_ds.ExecuteReader())
            {
                DataTable dataTable = new DataTable();
                dataTable.Load(reader);
                //danhsachuserdg = null;
                danhsachuserdg.DataSource = dataTable;
            }

            //danh sách các role 
            OracleCommand cmd_role;
            if (timkiemuserroletb.Text == "")
                cmd_role = new OracleCommand("Select * from DBA_ROLES", con_ds);
            else
                cmd_role = new OracleCommand("Select * from DBA_ROLES where role = '" + timkiemuserroletb.Text.ToUpper() + "'", con_ds);

            using (OracleDataReader reader = cmd_role.ExecuteReader())
            {
                DataTable dataTable = new DataTable();
                dataTable.Load(reader);
                danhsachroledg.DataSource = dataTable;
            }

            //danh sách role đã cấp cho user
            OracleCommand cmd_userrole;
            if (timkiemuserroletb.Text == "")
                cmd_userrole = new OracleCommand("Select * from dba_ROLE_PRIVS", con_ds);
            else
            {
                if (CheckUser(timkiemuserroletb.Text.ToUpper())!=0) //có tồn tại user
                    cmd_userrole = new OracleCommand("Select * from dba_ROLE_PRIVS where granted_role<>'CONNECT' and grantee = '" + timkiemuserroletb.Text.ToUpper() + "'", con_ds);
                else //có tồn tại role, nếu không thì không có giá trị trả về
                    cmd_userrole = new OracleCommand("Select * from dba_ROLE_PRIVS where granted_role<>'CONNECT' and granted_role = '" + timkiemuserroletb.Text.ToUpper() + "'", con_ds);
                
            }
                

            using (OracleDataReader reader = cmd_userrole.ExecuteReader())
            {
                DataTable dataTable = new DataTable();
                dataTable.Load(reader);
                danhsachuserroledg.DataSource = dataTable;
            }
            con_ds.Close();
        }

        private void ThongTinQuyen()
        {
            OracleConnection con_ttq = new OracleConnection();
            con_ttq.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
           
            DataSet dataSet_ttq = new DataSet();
            OracleCommand cmd_ttq;
            if(timkiemusertb.Text=="")
                cmd_ttq = new OracleCommand("Select * from user_tab_privs ", con_ttq);
            else
                cmd_ttq = new OracleCommand("Select * from user_tab_privs  where grantee = '" + timkiemusertb.Text.ToUpper() + "'", con_ttq);
            //dba_sys_privs 
            //user_tab_privs
            cmd_ttq.CommandType = CommandType.Text;
            con_ttq.Open();
            using (OracleDataReader reader = cmd_ttq.ExecuteReader())
            {
                DataTable dataTable = new DataTable();
                dataTable.Load(reader);
                thongtinquyendg.DataSource = dataTable;
            }

            //bảng lấy ra các cộ có quyền update
            OracleCommand cmd_update;
            if (timkiemusertb.Text == "")
                cmd_update = new OracleCommand("Select * from USER_COL_PRIVS_MADE", con_ttq);
            else
                cmd_update = new OracleCommand("Select * from USER_COL_PRIVS_MADE where grantee = '" + timkiemusertb.Text.ToUpper() + "'", con_ttq);

            using (OracleDataReader reader = cmd_update.ExecuteReader())
            {
                DataTable dataTable = new DataTable();
                dataTable.Load(reader);
                thongtinupdatedg.DataSource = dataTable;
            }
            con_ttq.Close();
        }
        private void Admin_Load(object sender, EventArgs e)
        {
            DanhSachUser();
            ThongTinQuyen();
        }


        private void taorolebtn_Click(object sender, EventArgs e)
        {
            if(tenroletb.Text =="")
            {
                MessageBox.Show("Lỗi!! Chưa nhập tên role.");
                return;
            }
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            con.Open();
            if (CheckRole(tenroletb.Text.ToUpper()) == 0 && CheckUser(tenroletb.Text.ToUpper()) == 0)
            {
                OracleCommand cmd_themrole = new OracleCommand();
                cmd_themrole.Connection = con;
                cmd_themrole.CommandText = "create role " + tenroletb.Text.ToUpper();
                cmd_themrole.CommandType = CommandType.Text;
                cmd_themrole.ExecuteNonQuery();
                MessageBox.Show("Thêm thành công.");
                //load lại danh sách role
                DanhSachUser();
            }
            else
            {
                MessageBox.Show("Đã có tên role hoặc user tồn tại trong hệ thống.");
            }
            con.Close();
        }

        private void xoarolebtn_Click(object sender, EventArgs e)
        {
            if (tenroletb.Text == "")
            {
                MessageBox.Show("Lỗi!! Chưa nhập tên role.");
                return;
            }
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            con.Open();
            if (CheckRole(tenroletb.Text.ToUpper()) == 0)
            {
                MessageBox.Show("Role không tồn tại.");
            }
            else
            {
                OracleCommand cmd_xoarole = new OracleCommand();
                cmd_xoarole.Connection = con;
                cmd_xoarole.CommandText = "drop role " + tenroletb.Text.ToUpper();
                cmd_xoarole.CommandType = CommandType.Text;
                cmd_xoarole.ExecuteNonQuery();
                MessageBox.Show("Xóa thành công.");
                //load lai Thong thin quye62n
                ThongTinQuyen();
                //load lại danh sách role
                DanhSachUser();
            }
            con.Close();
           
        }

        private void taouserbtn_Click(object sender, EventArgs e)
        {
            if(tendangnhaptb.Text == "" || matkhautb.Text=="")
            {
                MessageBox.Show("Lỗi! Chưa nhập đủ thông tin");
                return;
            }
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            con.Open();
            if (CheckRole(tendangnhaptb.Text.ToUpper()) == 0 && CheckUser(tendangnhaptb.Text.ToUpper()) == 0)
            {
                //tạo user
                OracleCommand cmd_themrole = new OracleCommand();
                cmd_themrole.Connection = con;
                cmd_themrole.CommandText = "create user " + tendangnhaptb.Text.ToUpper() + " identified by " + matkhautb.Text;
                cmd_themrole.CommandType = CommandType.Text;
                cmd_themrole.ExecuteNonQuery();
               
                //cấp quyền connect cho user 
                OracleCommand cmd_connect = new OracleCommand();
                cmd_connect.Connection = con;
                cmd_connect.CommandText = "grant connect to " + tendangnhaptb.Text.ToUpper();
                cmd_connect.CommandType = CommandType.Text;
                cmd_connect.ExecuteNonQuery();
                //load lại danh sách user
                MessageBox.Show("Tạo thành công.");
                DanhSachUser();
               
            }
            else
            {
                MessageBox.Show("Tên đăng nhập hoặc role đã tồn tại trong hệ thống.");
            }
            con.Close();
        }

        private void xoauserbtn_Click(object sender, EventArgs e)
        {
            if (tendangnhaptb.Text == "")
            {
                MessageBox.Show("Lỗi! Chưa nhập đủ thông tin");
                return;
            }
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            con.Open();
            if (CheckUser(tendangnhaptb.Text.ToUpper()) == 0)
            {
                MessageBox.Show("Tên đăng nhập không tồn tại.");
            }
            else
            {
                OracleCommand cmd_xoauser = new OracleCommand();
                cmd_xoauser.Connection = con;
                cmd_xoauser.CommandText = "drop user " + tendangnhaptb.Text.ToUpper();
                cmd_xoauser.CommandType = CommandType.Text;
                cmd_xoauser.ExecuteNonQuery();
                MessageBox.Show("Xóa thành công.");
                //load lại danh sách user
                DanhSachUser();
                //load lai Thong thin quye62n
                ThongTinQuyen();
            }
            con.Close();
           
        }

        private void doimatkhauntn_Click(object sender, EventArgs e)
        {
            if (tendangnhaptb.Text == "" || matkhautb.Text == "")
            {
                MessageBox.Show("Lỗi! Chưa nhập đủ thông tin");
                return;
            }
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            con.Open();
            if (CheckUser(tendangnhaptb.Text.ToUpper()) == 0)
            {
                MessageBox.Show("Tên đăng nhập không tồn tại.");
            }
            else
            {
                OracleCommand cmd_chinhuser = new OracleCommand();
                cmd_chinhuser.Connection = con;
                cmd_chinhuser.CommandText = "alter user " + tendangnhaptb.Text.ToUpper() + " identified by " + matkhautb.Text;
                cmd_chinhuser.CommandType = CommandType.Text;
                cmd_chinhuser.ExecuteNonQuery();
                MessageBox.Show("Đổi mật khẩu thành công.");
            }
            con.Close();
        }

        private void capbtb_Click(object sender, EventArgs e)
        {
            if(caproletb.Text=="" || chousertb.Text=="")
            {
                MessageBox.Show("Chưa nhập đủ thông tin!");
                return;
            }
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            con.Open();
            if (CheckRole(caproletb.Text.ToUpper()) == 0 && CheckUser(chousertb.Text.ToUpper()) == 0)
            {
                MessageBox.Show("Tên role hoặc tên user không tồn tại.");
            }
            else
            {
                OracleCommand cmd_caprolechouser = new OracleCommand();
                cmd_caprolechouser.Connection = con;
                cmd_caprolechouser.CommandText = "grant " + caproletb.Text.ToUpper() + " to " + chousertb.Text;
                cmd_caprolechouser.CommandType = CommandType.Text;
                cmd_caprolechouser.ExecuteNonQuery();
                MessageBox.Show(String.Format("Cấp role: {0} cho user:{1} thành công", caproletb.Text.ToUpper(), chousertb.Text.ToUpper()));
            }
            con.Close();
        }

        //kiểm tra view có tồn tại hay chưa
        private int CheckView(string viewname)
        {
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            con.Open();
            OracleCommand cmd_checkview = new OracleCommand();
            cmd_checkview.Connection = con;
            cmd_checkview.CommandText = "SELECT COUNT(*) FROM dba_views WHERE view_name = '" + viewname + "'";
            cmd_checkview.CommandType = CommandType.Text;
            object count = cmd_checkview.ExecuteScalar();
            if (count.ToString() == "0")
                return 0; //chưa tồn tại
            return 1; //đã tồn tại 
        }
        //kiểm tra role có tồn tại
        private int CheckRole(string rolename)
        {
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            con.Open();
            OracleCommand cmd_checkrole = new OracleCommand();
            cmd_checkrole.Connection = con;
            cmd_checkrole.CommandText = "select count(*) from DBA_ROLES where role = '" + rolename + "'";
            cmd_checkrole.CommandType = CommandType.Text;
            object count = cmd_checkrole.ExecuteScalar();
            if (count.ToString() == "0")
                return 0; //chưa tồn tại
            return 1; //đã tồn tại 
        }

        //kiểm tra user có tồn tại
        private int CheckUser(string username)
        {
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            con.Open();
            OracleCommand cmd_checkuser = new OracleCommand();
            cmd_checkuser.Connection = con;
            cmd_checkuser.CommandText = "select count(*) from all_users where username = '" + username + "'";
            cmd_checkuser.CommandType = CommandType.Text;
            object count = cmd_checkuser.ExecuteScalar();
            if (count.ToString() == "0")
                return 0; //chưa tồn tại
            return 1; //đã tồn tại 
        }

        private void insertbtn_Click(object sender, EventArgs e)
        {
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            if (capquyenrolerb.Checked)
            {
                if (CheckRole(tenuserroletb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("Role không tồn tại.");
                    con.Close();
                    return;
                }
            }
            else
            {
                if (CheckUser(tenuserroletb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("User không tồn tại.");
                    con.Close();
                    return;
                }
            }
            con.Open();
            if(hocsinhrb.Checked) //insert trên bảng hocsinh
            {
                OracleCommand cmd_insert = new OracleCommand();
                cmd_insert.Connection = con;
                cmd_insert.CommandText = "grant insert on HocSinh to " + tenuserroletb.Text.ToUpper();
                if(wgohscb.Checked)//có with grant option
                {
                    cmd_insert.CommandText += " WITH GRANT OPTION";
                }
                cmd_insert.CommandType = CommandType.Text;
                cmd_insert.ExecuteNonQuery();
                MessageBox.Show("Cấp quyền insert thành công");
                //load lại thong tin quyền
                ThongTinQuyen();
            }
            else //insert trên bảng lop
            {
                OracleCommand cmd_insert = new OracleCommand();
                cmd_insert.Connection = con;
                cmd_insert.CommandText = "grant insert on Lop to " + tenuserroletb.Text.ToUpper();
                if (wgolcb.Checked)//có with grant option
                {
                    cmd_insert.CommandText += " WITH GRANT OPTION";
                }
                cmd_insert.CommandType = CommandType.Text;
                cmd_insert.ExecuteNonQuery();
                MessageBox.Show("Cấp quyền insert thành công");
                //load lại thong tin quyền
                ThongTinQuyen();
            }
            con.Close();
        }

        private void hocsinhrb_CheckedChanged(object sender, EventArgs e)
        {
            LOP.Enabled = false;
            HOCSINH.Enabled = true;
        }

        private void loprb_CheckedChanged(object sender, EventArgs e)
        {
            HOCSINH.Enabled = false;
            LOP.Enabled = true;
        }

        private void deletebtn_Click(object sender, EventArgs e)
        {
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
          
            if (capquyenrolerb.Checked)
            {
                if (CheckRole(tenuserroletb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("Role không tồn tại.");
                    con.Close();
                    return;
                }
            }
            else
            {
                if (CheckUser(tenuserroletb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("User không tồn tại.");
                    con.Close();
                    return;
                }
            }
            con.Open();
            if (hocsinhrb.Checked) //delete trên bảng hocsinh
            {
                OracleCommand cmd_delete = new OracleCommand();
                cmd_delete.Connection = con;
                cmd_delete.CommandText = "grant delete on HocSinh to " + tenuserroletb.Text.ToUpper();
                if (wgohscb.Checked)//có with grant option
                {
                    cmd_delete.CommandText += " WITH GRANT OPTION";
                }
                cmd_delete.CommandType = CommandType.Text;
                cmd_delete.ExecuteNonQuery();
                MessageBox.Show("Cấp quyền delete thành công");

                //load lại thong tin quyền
                ThongTinQuyen();
            }
            else //delete trên bảng lop
            {
                OracleCommand cmd_delete = new OracleCommand();
                cmd_delete.Connection = con;
                cmd_delete.CommandText = "grant delete on Lop to " + tenuserroletb.Text.ToUpper();
                if (wgolcb.Checked)//có with grant option
                {
                    cmd_delete.CommandText += " WITH GRANT OPTION";
                }
                cmd_delete.CommandType = CommandType.Text;
                cmd_delete.ExecuteNonQuery();
                MessageBox.Show("Cấp quyền delete thành công");
                //load lại thong tin quyền
                ThongTinQuyen();
            }
            con.Close();
        }

        
        private void selectbtn_Click(object sender, EventArgs e)
        {
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            
            if (capquyenrolerb.Checked)
            {
                if (CheckRole(tenuserroletb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("Role không tồn tại.");
                    con.Close();
                    return;
                }
            }
            else
            {
                if (CheckUser(tenuserroletb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("User không tồn tại.");
                    con.Close();
                    return;
                }
            }
            con.Open();
            if (hocsinhrb.Checked) //select trên bảng hocsinh
            {
                OracleCommand cmd_select = new OracleCommand();
                cmd_select.Connection = con;
                if (HOCSINH.CheckedItems.Count == 0 || HOCSINH.CheckedItems.Count == 5) //cấp quyền select trên cả bảng
                {
                    cmd_select.CommandText = "grant select on HocSinh to " + tenuserroletb.Text.ToUpper();
                }
                else
                {
                    //những cột viết tắt để tạo view không bị lỗi view quá dài
                    string[] short_name = { "MHS", "THS", "GT", "DC", "ML" };
                    //kiểm tra cấp quyền select trên những cột nào
                    string column = "";
                    //chọn ra những cột để select
                    string select_column = "";
                    for (int i = 0; i < HOCSINH.Items.Count; i++)
                    {
                        if (HOCSINH.GetItemCheckState(i) == CheckState.Checked)
                        {
                            column += short_name[i] + "_";
                            select_column += HOCSINH.Items[i].ToString() + ",";
                        }
                    }
                    //xóa dấu , ở cuối (để bỏ váo câu lệnh select)
                    select_column = select_column.TrimEnd(',');

                    //them HS vào cuối để biết là view từ bàng HS
                    column += "HS";

                    //kiểm tra view có tồn tại hay chưa
                    if(CheckView(column) ==0 )//chưa tồn tại
                    {
                        //tạo view mới
                        OracleCommand cmd_taoview = new OracleCommand();
                        cmd_taoview.Connection = con;
                        cmd_taoview.CommandText = "create view " + column + " as select " + select_column + " from HOCSINH";
                        cmd_taoview.CommandType = CommandType.Text;
                        cmd_taoview.ExecuteNonQuery();
                    }
                    //cấp quyền đọc trên view này cho user
                    cmd_select.CommandText = "grant select on " + column + " to " + tenuserroletb.Text.ToUpper();
                }

                if (wgohscb.Checked)//có with grant option
                {
                    cmd_select.CommandText += " WITH GRANT OPTION";
                }
                cmd_select.CommandType = CommandType.Text;
                cmd_select.ExecuteNonQuery();
                MessageBox.Show("Cấp quyền select thành công");

                //load lại thong tin quyền
                ThongTinQuyen();
            }
            else //select trên bảng lop
            {
                OracleCommand cmd_select = new OracleCommand();
                cmd_select.Connection = con;

                if (LOP.CheckedItems.Count == 0 || LOP.CheckedItems.Count == 5) //cấp quyền select trên cả bảng
                {
                    cmd_select.CommandText = "grant select on Lop to " + tenuserroletb.Text.ToUpper();
                }
                else
                {
                    //kiểm tra cấp quyền select trên những cột nào
                    //những cột viết tắt để tạo view không bị lỗi view quá dài
                    string[] short_name = { "ML", "TL", "SHSTD"};
                    //kiểm tra cấp quyền select trên những cột nào
                    string column = "";
                    //chọn ra những cột để select
                    string select_column = "";
                    for (int i = 0; i < LOP.Items.Count; i++)
                    {
                        if (LOP.GetItemCheckState(i) == CheckState.Checked)
                        {
                            column += short_name[i] + "_";
                            select_column += LOP.Items[i].ToString() + ",";
                        }
                    }
                    //xóa dấu , ở cuối (để bỏ váo câu lệnh select)
                    select_column = select_column.TrimEnd(',');

                    //them  vào cuối để biết là view từ bàng Lop
                    column += "L";

                    //kiểm tra view có tồn tại?
                    if (CheckView(column) == 0)//chưa tồn tại
                    {
                        //tạo view mới
                        OracleCommand cmd_taoview = new OracleCommand();
                        cmd_taoview.Connection = con;
                        cmd_taoview.CommandText = "create view " + column + " as select " + select_column + " from LOP";
                        cmd_taoview.CommandType = CommandType.Text;
                        cmd_taoview.ExecuteNonQuery();
                    }
                    cmd_select.CommandText = "grant select on " + column + " to " + tenuserroletb.Text.ToUpper();
                }
                if (wgolcb.Checked)//có with grant option
                {
                    cmd_select.CommandText += " WITH GRANT OPTION";
                }
                cmd_select.CommandType = CommandType.Text;
                cmd_select.ExecuteNonQuery();
                MessageBox.Show("Cấp quyền select thành công");
                //load lại thong tin quyền
                ThongTinQuyen();
            }
            con.Close();
        }

        private void updatebtn_Click(object sender, EventArgs e)
        {
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            
            if (capquyenrolerb.Checked)
            {
                if (CheckRole(tenuserroletb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("Role không tồn tại.");
                    con.Close();
                    return;
                }
            }
            else
            {
                if (CheckUser(tenuserroletb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("User không tồn tại.");
                    con.Close();
                    return;
                }
            }
            con.Open();
            if (hocsinhrb.Checked) //update trên bảng hocsinh
            {
                OracleCommand cmd_update = new OracleCommand();
                cmd_update.Connection = con;
                if(HOCSINH.CheckedItems.Count==0 || HOCSINH.CheckedItems.Count==5) //cấp quyền upate trên cả bảng
                {
                    cmd_update.CommandText = "grant update on HocSinh to " + tenuserroletb.Text.ToUpper();
                }
                else
                {
                    //kiểm tra cấp quyền update trên những cột nào
                    string column = "";
                    for (int i = 0; i < HOCSINH.Items.Count; i++)
                    {
                        if (HOCSINH.GetItemCheckState(i) == CheckState.Checked)
                        {
                            column += HOCSINH.Items[i].ToString() + ",";
                        }
                    }
                    //xóa dấu , ở cuối
                    column = column.TrimEnd(',');
                    cmd_update.CommandText = "grant update("+column+") on HocSinh to " + tenuserroletb.Text.ToUpper();
                }
                
                if (wgohscb.Checked)//có with grant option
                {
                    cmd_update.CommandText += " WITH GRANT OPTION";
                }
                cmd_update.CommandType = CommandType.Text;
                cmd_update.ExecuteNonQuery();
                MessageBox.Show("Cấp quyền update thành công");

                //load lại thong tin quyền
                ThongTinQuyen();
            }
            else //update trên bảng lop
            {
                OracleCommand cmd_update = new OracleCommand();
                cmd_update.Connection = con;

                if (LOP.CheckedItems.Count == 0 || LOP.CheckedItems.Count == 5) //cấp quyền upate trên cả bảng
                {
                    cmd_update.CommandText = "grant update on Lop to " + tenuserroletb.Text.ToUpper();
                }
                else
                {
                    //kiểm tra cấp quyền update trên những cột nào
                    string column = "";
                    for (int i = 0; i < LOP.Items.Count; i++)
                    {
                        if (LOP.GetItemCheckState(i) == CheckState.Checked)
                        {
                            column += LOP.Items[i].ToString() + ",";
                        }
                    }
                    //xóa dấu , ở cuối
                    column = column.TrimEnd(',');
                    cmd_update.CommandText = "grant update(" + column + ") on LOP to " + tenuserroletb.Text.ToUpper();
                }
                if (wgolcb.Checked)//có with grant option
                {
                    cmd_update.CommandText += " WITH GRANT OPTION";
                }
                cmd_update.CommandType = CommandType.Text;
                cmd_update.ExecuteNonQuery();
                MessageBox.Show("Cấp quyền update thành công");
                //load lại thong tin quyền
                ThongTinQuyen();
            }
            con.Close();
        }

        private void hocsinhThurb_CheckedChanged(object sender, EventArgs e)
        {
            LOPthu.Enabled = false;
            HOCSINHthu.Enabled = true;
        }

        private void lopThurb_CheckedChanged(object sender, EventArgs e)
        {
            LOPthu.Enabled = true;
            HOCSINHthu.Enabled = false;
        }

        //kiểm tra quyền có tồn tại
        private int CheckPrivilege(string tablename, string privilege, string grantee)
        {
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            con.Open();
            
            if(privilege!="UPDATE")
            {
                OracleCommand cmd_checkprivilege = new OracleCommand();
                cmd_checkprivilege.Connection = con;
                cmd_checkprivilege.CommandText = "select count(*) from user_tab_privs where table_name = '" + tablename + "' and privilege = '" + privilege + "' and grantee='" + grantee + "'";
                cmd_checkprivilege.CommandType = CommandType.Text;
                object count = cmd_checkprivilege.ExecuteScalar();
                if (count.ToString() == "0")
                    return 0; //chưa tồn tại
                return 1; //đã tồn tại 
            }
            else
            {
                //kiểm tra có cấp quyền UPDATE trên toàn bảng
                OracleCommand cmd_checkprivilege1 = new OracleCommand();
                cmd_checkprivilege1.Connection = con;
                cmd_checkprivilege1.CommandText = "select count(*) from user_tab_privs where table_name = '" + tablename + "' and privilege = '" + privilege + "' and grantee='" + grantee + "'";
                cmd_checkprivilege1.CommandType = CommandType.Text;
                object count1 = cmd_checkprivilege1.ExecuteScalar();

                //kiểm tra có cấp quyền UPDATE trên mức cột
                OracleCommand cmd_checkprivilege2 = new OracleCommand();
                cmd_checkprivilege2.Connection = con;
                cmd_checkprivilege2.CommandText = "select count(*) FROM USER_COL_PRIVS_MADE where table_name = '" + tablename + "' and privilege = '" + privilege + "' and grantee='" + grantee + "'";
                cmd_checkprivilege2.CommandType = CommandType.Text;
                object count2 = cmd_checkprivilege2.ExecuteScalar();

                if (count1.ToString() == "0" && count2.ToString() == "0") //hoàn toàn chưa được cấp quyền UPDATE
                    return 0; //chưa tồn tại
                return 1; //đã tồn tại 
            }
        }

        private void Revoke(string tablename, string privilege, string grantee)
        {
            OracleConnection con = new OracleConnection();
            con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            con.Open();
            OracleCommand cmd_revoke = new OracleCommand();
            cmd_revoke.Connection = con;
            cmd_revoke.CommandText = "revoke " + privilege + " on " + tablename + " from " + grantee;
            cmd_revoke.CommandType = CommandType.Text;
            cmd_revoke.ExecuteNonQuery();
            con.Close();
        }
        private void deletethubtn_Click(object sender, EventArgs e)
        {
            //OracleConnection con = new OracleConnection();
            //con.ConnectionString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-E896G02)(PORT = 1521))(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)));;User ID=QuanLyLopHoc;Password=123;Connection Timeout=120;";
            if(thuquyenrolerb.Checked)
            {
                if (CheckRole(tenuserrolethutb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("Role không tồn tại.");
                    //con.Close();
                    return;
                }
            }
            else
            {
                if (CheckUser(tenuserrolethutb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("User không tồn tại.");
                    //con.Close();
                    return;
                }
            }
            if(hocsinhThurb.Checked)//thu quyền delete trên bảng HocSinh
            {
                //kiểm tra có cấp quyền delete trên bảng HocSinh??
                if(CheckPrivilege("HOCSINH", "DELETE", tenuserrolethutb.Text.ToUpper()) ==0)//chưa được cấp quyền
                {
                    MessageBox.Show("Chưa được cấp quyền nên không thể thu quyền.");
                    //con.Close();
                    return;
                }
                else
                {
                    //thực hiện thu quyền
                    Revoke("HOCSINH", "DELETE", tenuserrolethutb.Text.ToUpper());
                    MessageBox.Show("Thu quyền thành công.");
                }

            }
            else //thu quyền delete trên bảng LOP
            {
                //kiểm tra có cấp quyền delete trên bảng Lop??
                if (CheckPrivilege("LOP", "DELETE", tenuserrolethutb.Text.ToUpper()) == 0)//chưa được cấp quyền
                {
                    MessageBox.Show("Chưa được cấp quyền nên không thể thu quyền.");
                    //con.Close();
                    return;
                }
                else
                {
                    //thực hiện thu quyền
                    Revoke("LOP", "DELETE", tenuserrolethutb.Text.ToUpper());
                    MessageBox.Show("Thu quyền thành công.");
                }
            }
            //load lại thong tin quyền
            ThongTinQuyen();
        }

        private void inserthubtn_Click(object sender, EventArgs e)
        {
            if (thuquyenrolerb.Checked)
            {
                if (CheckRole(tenuserrolethutb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("Role không tồn tại.");
                    //con.Close();
                    return;
                }
            }
            else
            {
                if (CheckUser(tenuserrolethutb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("User không tồn tại.");
                    //con.Close();
                    return;
                }
            }
            if (hocsinhThurb.Checked)//thu quyền INSERT trên bảng HocSinh
            {
                //kiểm tra có cấp quyền INSERT trên bảng HocSinh??
                if (CheckPrivilege("HOCSINH", "INSERT", tenuserrolethutb.Text.ToUpper()) == 0)//chưa được cấp quyền
                {
                    MessageBox.Show("Chưa được cấp quyền nên không thể thu quyền.");
                    //con.Close();
                    return;
                }
                else
                {
                    //thực hiện thu quyền
                    Revoke("HOCSINH", "INSERT", tenuserrolethutb.Text.ToUpper());
                    MessageBox.Show("Thu quyền thành công.");
                }

            }
            else //thu quyền INSERT trên bảng LOP
            {
                //kiểm tra có cấp quyền delete trên bảng Lop??
                if (CheckPrivilege("LOP", "INSERT", tenuserrolethutb.Text.ToUpper()) == 0)//chưa được cấp quyền
                {
                    MessageBox.Show("Chưa được cấp quyền nên không thể thu quyền.");
                    //con.Close();
                    return;
                }
                else
                {
                    //thực hiện thu quyền
                    Revoke("LOP", "INSERT", tenuserrolethutb.Text.ToUpper());
                    MessageBox.Show("Thu quyền thành công.");
                }
            }
            //load lại thong tin quyền
            ThongTinQuyen();
        }

        private void updatethubtn_Click(object sender, EventArgs e)
        {
            if (thuquyenrolerb.Checked)
            {
                if (CheckRole(tenuserrolethutb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("Role không tồn tại.");
                    //con.Close();
                    return;
                }
            }
            else
            {
                if (CheckUser(tenuserrolethutb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("User không tồn tại.");
                    //con.Close();
                    return;
                }
            }
            if (hocsinhThurb.Checked)//thu quyền UPDATE trên bảng HocSinh
            {
                //kiểm tra có cấp quyền delete trên bảng HocSinh??
                if (CheckPrivilege("HOCSINH", "UPDATE", tenuserrolethutb.Text.ToUpper()) == 0)//chưa được cấp quyền
                {
                    MessageBox.Show("Chưa được cấp quyền nên không thể thu quyền.");
                    //con.Close();
                    return;
                }
                else
                {
                    //thực hiện thu quyền
                    Revoke("HOCSINH", "UPDATE", tenuserrolethutb.Text.ToUpper());
                    MessageBox.Show("Thu quyền thành công.");
                }

            }
            else //thu quyền UPDATE trên bảng LOP
            {
                //kiểm tra có cấp quyền UPDATE trên bảng Lop?
                if (CheckPrivilege("LOP", "UPDATE", tenuserrolethutb.Text.ToUpper()) == 0)//chưa được cấp quyền
                {
                    MessageBox.Show("Chưa được cấp quyền nên không thể thu quyền.");
                    //con.Close();
                    return;
                }
                else
                {
                    //thực hiện thu quyền
                    Revoke("LOP", "UPDATE", tenuserrolethutb.Text.ToUpper());
                    MessageBox.Show("Thu quyền thành công.");
                }
            }
            //load lại thong tin quyền
            ThongTinQuyen();
        }

        private void selecthubtn_Click(object sender, EventArgs e)
        {
            if (thuquyenrolerb.Checked)
            {
                if (CheckRole(tenuserrolethutb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("Role không tồn tại.");
                    //con.Close();
                    return;
                }
            }
            else
            {
                if (CheckUser(tenuserrolethutb.Text.ToUpper()) == 0)
                {
                    MessageBox.Show("User không tồn tại.");
                    //con.Close();
                    return;
                }
            }
            if (hocsinhThurb.Checked)//thu quyền SELECT trên bảng HocSinh
            {
                //những cột viết tắt để tạo view không bị lỗi view quá dài
                string[] short_name = { "MHS", "THS", "GT", "DC", "ML" };
                //kiểm tra cấp quyền select trên những cột nào
                string column = "";
                //nếu cấp quyền đọc trên toàn bảng
                if (HOCSINHthu.CheckedItems.Count != 0 && HOCSINHthu.CheckedItems.Count != 5)
                {
                    for (int i = 0; i < HOCSINH.Items.Count; i++)
                    {
                        if (HOCSINH.GetItemCheckState(i) == CheckState.Checked)
                        {
                            column += short_name[i] + "_";
                        }
                    }
                    //them HS vào cuối để biết là view từ bàng HS
                    column += "HS";
                }
                else
                    column = "HOCSINH";

                //kiểm tra có cấp quyền select trên bảng column??
                if (CheckPrivilege(column, "SELECT", tenuserrolethutb.Text.ToUpper()) == 0)//chưa được cấp quyền
                {
                    MessageBox.Show("Chưa được cấp quyền nên không thể thu quyền.");
                    //con.Close();
                    return;
                }
                else
                {
                    //thực hiện thu quyền
                    Revoke(column, "SELECT", tenuserrolethutb.Text.ToUpper());
                    MessageBox.Show("Thu quyền thành công.");
                }

            }
            else //thu quyền SELECT trên bảng LOP
            {

                //kiểm tra cấp quyền select trên những cột nào
                //những cột viết tắt để tạo view không bị lỗi view quá dài
                string[] short_name = { "ML", "TL", "SHSTD" };
                //kiểm tra cấp quyền select trên những cột nào
                string column = "";
                if (LOPthu.CheckedItems.Count != 0 && LOPthu.CheckedItems.Count != 3)
                {
                    for (int i = 0; i < LOPthu.Items.Count; i++)
                    {
                        if (LOPthu.GetItemCheckState(i) == CheckState.Checked)
                        {
                            column += short_name[i] + "_";
                        }
                    }
                    //them  vào cuối để biết là view từ bàng Lop
                    column += "L";
                }
                else
                    column = "LOP";

                //kiểm tra có cấp quyền select trên view column?
                if (CheckPrivilege(column, "SELECT", tenuserrolethutb.Text.ToUpper()) == 0)//chưa được cấp quyền
                {
                    MessageBox.Show("Chưa được cấp quyền nên không thể thu quyền.");
                    //con.Close();
                    return;
                }
                else
                {
                    //thực hiện thu quyền
                    Revoke(column, "SELECT", tenuserrolethutb.Text.ToUpper());
                    MessageBox.Show("Thu quyền thành công.");
                }
            }
            //load lại thong tin quyền
            ThongTinQuyen();
        }

        private void timkiemuserbtn_Click(object sender, EventArgs e)
        {
            ThongTinQuyen();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DanhSachUser();
        }

   
       

       
        

       
      
    }
}

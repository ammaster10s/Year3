using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Signup
{
    public partial class updatepage : Form
    {
        public updatepage()
        {
            InitializeComponent();
        }
        public updatepage(int v)
        {
            InitializeComponent();
            V = v;
        }
        public int V { get; set; }
        private void updatepage_Load(object sender, EventArgs e)
        {


        }

        private void submit_Click(object sender, EventArgs e)
        {
            string dateValue = birthDatePick.Value.ToString("yyyy-MM-dd");
            info a1 = new info()
            {
                ID = V,
                fName = fname.Text,
                LName = lname.Text,
                Sex = sxCombo.Text,
                Bdate = dateValue,
                Email = email.Text,
                Occup = occupation.Text,
            };
            infoDAO infor = new infoDAO();
            int result = infor.updateOneRecord(a1);
            this.Hide();
            MessageBox.Show(result + " row(s) updated.");
            userpage newuserpage = new userpage(infor.getAll());
            newuserpage.ShowDialog();


        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
    }
}

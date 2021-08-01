using System;
using System.Windows.Forms;

namespace OnRentVideoSystem
{
    public partial class Customer : Form
    {
        public Customer()
        {
            InitializeComponent();
        }
        int id;
        private void Booking_Load(object sender, EventArgs e)
        {
            Connection.GetRentedData(customerGV);
            id = -1;
        }
        private void button1_Click_1(object sender, EventArgs e)
        {
            Booking b = new Booking();
            b.Show();
            this.Hide();
        }
        private void button4_Click(object sender, EventArgs e)
        {
            id = -1;
            Connection.GetRentedData(customerGV);
        }
        private void button2_Click_1(object sender, EventArgs e)
        {
            Environment.Exit(0);
        }
        private void button5_Click_1(object sender, EventArgs e)
        {
            saveBtn.Text = "Add";
            panel5.Visible = true;
            nameTxt.Text = "";
            cnctTxt.Text = "";
            addTxt.Text = "";
            id = -1;

        }
        private void button6_Click(object sender, EventArgs e)
        {
            saveBtn.Text = "Update";
            panel5.Visible = true;
        }
        private void button7_Click_1(object sender, EventArgs e)
        {
            if (nameTxt.Text != "" && id != -1)
            {
                Connection.DeleteData(nameTxt, cnctTxt, addTxt, id.ToString());
                id = -1;
                Connection.GetRentedData(customerGV);
            }
        }
        private void bookingGV_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (customerGV.Columns.Count != 0 && e.RowIndex != -1 && e.ColumnIndex != -1)
            {
                DataGridViewRow row = customerGV.Rows[e.RowIndex];
                id = Convert.ToInt32(row.Cells["ID"].Value.ToString());
                nameTxt.Text = row.Cells["Name"].Value.ToString();
                cnctTxt.Text = row.Cells["Phone"].Value.ToString();
                addTxt.Text = row.Cells["Address"].Value.ToString();
            }
        }
        private void button9_Click_1(object sender, EventArgs e)
        {
            panel5.Visible = false;
        }
        private void button8_Click_1(object sender, EventArgs e)
        {
            if (nameTxt.Text != "" && cnctTxt.Text != "" && addTxt.Text != "")
            {
                if (saveBtn.Text == "Add")
                {
                    Connection.AddData(nameTxt, cnctTxt, addTxt);
                    id = -1;
                }
                else
                {
                    Connection.UpdateData(nameTxt, cnctTxt, addTxt, id.ToString());
                    id = -1;
                }
                Connection.GetRentedData(customerGV);
                nameTxt.Text = "";
                cnctTxt.Text = "";
                addTxt.Text = "";
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Video v = new Video();
            v.Show();
            this.Hide();
        }

        private void Customer_FormClosed(object sender, FormClosedEventArgs e)
        {
            Environment.Exit(0);
        }
    }
}
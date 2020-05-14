package com.example.goStudy;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.aigestudio.wheelpicker.WheelPicker;
import com.github.mikephil.charting.animation.Easing;
import com.github.mikephil.charting.charts.BarChart;
import com.github.mikephil.charting.charts.LineChart;
import com.github.mikephil.charting.charts.PieChart;
import com.github.mikephil.charting.components.AxisBase;
import com.github.mikephil.charting.components.XAxis;
import com.github.mikephil.charting.data.BarData;
import com.github.mikephil.charting.data.BarDataSet;
import com.github.mikephil.charting.data.BarEntry;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;
import com.github.mikephil.charting.data.PieData;
import com.github.mikephil.charting.data.PieDataSet;
import com.github.mikephil.charting.data.PieEntry;
import com.github.mikephil.charting.formatter.IAxisValueFormatter;
import com.github.mikephil.charting.formatter.ValueFormatter;
import com.github.mikephil.charting.interfaces.datasets.ILineDataSet;
import com.github.mikephil.charting.utils.ColorTemplate;


import java.util.ArrayList;
import java.util.List;

public class Practice extends AppCompatActivity {



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_practice);

        Button practice2 = (Button) findViewById(R.id.practice2Btn);
        practice2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent= new Intent(Practice.this, Practice2.class);
                startActivity(intent);
            }
        });

        /** create simple line chart */
        LineChart simpleLineChart = findViewById(R.id.LineChart);
        ArrayList<Entry> yValuesSimpleLineChart= new ArrayList<Entry>();
        setSimpleLineChartData(yValuesSimpleLineChart);
        createSimpleLineChart(simpleLineChart,yValuesSimpleLineChart);

        /** create smooth line chart */
        LineChart smoothChart = findViewById(R.id.SmoothLineChart);
        ArrayList<Entry> yValuesSmoothChart= new ArrayList<Entry>();
        setDataSmoothLineChart(yValuesSmoothChart); // create data for the chart.
        createSmoothLineChart(smoothChart, yValuesSmoothChart,"Data set 1");

        /** create pie chart */
        PieChart pieChart = (PieChart) findViewById(R.id.PieChart);
        ArrayList<PieEntry> yValuesPieChart = new ArrayList<>();
        setPieChartData(yValuesPieChart);
        createPieChart(pieChart,yValuesPieChart);


        /** create simple bar chart*/
        BarChart simpleBartChart = (BarChart) findViewById(R.id.BarChart);
        ArrayList<BarEntry> barEntries= new ArrayList<>();
        setSimpleBarChartData(barEntries);
        createSimpleBarChart(simpleBartChart, barEntries);

        /** create multi bar chart */
        BarChart barChart2 = (BarChart) findViewById(R.id.BarChart2);
        ArrayList<BarEntry> multiBarEntries1= new ArrayList<>();
        ArrayList<BarEntry> multiBarEntries2= new ArrayList<>();
        setMultiBarChartData(multiBarEntries1,multiBarEntries2);
        createMultiBarChart(barChart2,multiBarEntries1,multiBarEntries2);

        /** Create multi line chart */
        LineChart multiLineChart = findViewById(R.id.MultiLineChart);
        ArrayList<Entry> yVals1 =  new ArrayList<>();
        ArrayList<Entry> yVals2 =  new ArrayList<>();
        ArrayList<Entry> yVals3 =  new ArrayList<>();
        setMultiLineChartData(yVals1,yVals2,yVals3);
        createMultiLineChart(multiLineChart,yVals1,yVals2,yVals3);


        /** Create Stacked Bar Chart */
        BarChart stackedBarChart=(BarChart) findViewById(R.id.StackedBarChart);
        ArrayList<BarEntry> yValuesStackedChart = new ArrayList<>();
        yValuesStackedChart= setDataStackedChart(10); //create data for the chart.
        createStackedChart(stackedBarChart, yValuesStackedChart, 40 ,new String[]{"Children", "Adults", "Elders"});

        /** Create Wheel Picker */
        WheelPicker wheelPicker =(WheelPicker) findViewById(R.id.wheel_picker);
        String[] itemsInWheelPicker = getResources().getStringArray(R.array.activities);
        createWheelPicker(wheelPicker, itemsInWheelPicker);


    }




    /** WHEEL PICKER */
    /**
     * create wheel picker
     * @param wheelPicker the wheel picker in the layout.
     * @param itemsInWheelPicker array of string with items to display on the wheel picker.
     */
    private void createWheelPicker(WheelPicker wheelPicker , String[] itemsInWheelPicker) {
        List<String> data =new ArrayList<>();
        for (String str : itemsInWheelPicker) {
            data.add(str);
        }
        wheelPicker.setData(data);
    }

    /** STACKED CHART */
    /** Create data for stacked chart */
    private ArrayList<BarEntry> setDataStackedChart(int count) {
        ArrayList<BarEntry> yValues = new ArrayList<>();
        for(int i=0; i<count; i++){
            float val1 =  (float) (Math.random()+count)+20;
            float val2 =  (float) (Math.random()+count)+10;
            float val3 =  (float) (Math.random()+count)+30;

            yValues.add(new BarEntry(i ,new float[]{val1,val2, val3}));
        }
        return yValues;
    }

    /**
     * create stacked chart
     * @param mChart  BarChart from layout.
     * @param yValues   array of BarEntry with the information to display in the chart.
     * @param maxVisibleValueCount  sets the number of maximum visible drawn values on the chart only active
     *                              when setDrawValues() is enabled
     * @param yTag name of each color in the chart.
     */
    private void createStackedChart(BarChart mChart, ArrayList<BarEntry>   yValues, int maxVisibleValueCount,
                                    String[] yTag ) {

        mChart.getDescription().setEnabled(false);


        mChart.setMaxVisibleValueCount(maxVisibleValueCount);

        StackedChartData(mChart, yValues,yTag);
    }


    /**
     * add the data to the stacked chart.
     * @param mChart BarChart from layout
     * @param yValues   array of BarEntry with the information to display in the chart.
     * @param yTag name of each color in the chart.
     */
    private void StackedChartData(BarChart mChart, ArrayList<BarEntry>   yValues,
                                  String[] yTag ) {
        BarDataSet set1;
        set1 = new BarDataSet(yValues,"");
        set1.setDrawIcons(false);
        set1.setStackLabels(yTag);
        set1.setColors(ColorTemplate.COLORFUL_COLORS);
        set1.setDrawValues(true);

        BarData data = new BarData(set1);
        /** problem with setting xAxis tags */
//        data.setValueFormatter(new MyXAxisValueFormatter());

        mChart.setData(data);
        mChart.setFitBars(true);
        mChart.invalidate();
        mChart.getDescription().setEnabled(false);



    }


    /** SMOOTH LINE CHART */
    /**
     * create smooth line chart
     * @param mChart LineChart from layout.
     * @param yValues array of Entry with the information to display in the chart.
     * @param dataName name of the chart.
     */
    private void createSmoothLineChart(LineChart mChart, ArrayList<Entry> yValues , String dataName) {
        mChart.setDragEnabled(true);
        mChart.setScaleEnabled(false);
        mChart.getDescription().setEnabled(false);

        LineDataSet set1 = new LineDataSet(yValues, dataName);

        set1.setFillAlpha(110);

        set1.setColor(Color.RED);
        set1.setLineWidth(3f);
        set1.setValueTextSize(20f);
        set1.setValueTextColor(Color.GREEN);
        set1.setDrawCircles(false);

        set1.setMode(LineDataSet.Mode.CUBIC_BEZIER);
        set1.setCubicIntensity(0.2f);
        set1.setDrawFilled(true);
        set1.setFillColor(Color.CYAN);

        ArrayList<ILineDataSet> dataSets= new ArrayList<>();
        dataSets.add(set1);

        LineData data = new LineData(dataSets);

        mChart.setData(data);
    }

    /** Create data for smooth line chart */
    private void setDataSmoothLineChart(ArrayList<Entry> yValues){
        yValues.add(new Entry(0,10f));
        yValues.add(new Entry(1,20f));
        yValues.add(new Entry(2,10f));
        yValues.add(new Entry(3,20f));
        yValues.add(new Entry(4,10f));
        yValues.add(new Entry(5,20f));
        yValues.add(new Entry(6,10f));

    }

    /** SIMPLE BAR CHART */
    /**
     * create simple bar chart
     * @param mChart BarChart from layout.
     * @param barEntries array of BarEntry with the information to display in the chart.
     */
    private void createSimpleBarChart(BarChart mChart, ArrayList<BarEntry> barEntries) {
        mChart.setDrawBarShadow(false);
        mChart.setDrawValueAboveBar(true);
        mChart.setMaxVisibleValueCount(50);
        mChart.setPinchZoom(false);
        mChart.setDrawGridBackground(true);
        mChart.getDescription().setEnabled(false);


        BarDataSet barDataSet= new BarDataSet(barEntries , "Data set1");
        barDataSet.setColors(ColorTemplate.COLORFUL_COLORS);

        BarData data=new BarData(barDataSet);
        data.setBarWidth(0.9f);

        mChart.setData(data);
        mChart.animateY(1000, Easing.EaseInOutSine);

        /** It suppose to change the tags on the xAxis,
         * but there is a problem with the implementation of IAxisValueFormatter class*/
        String[] months = new String[]{"Jan", "Feb", "Mar", "April", "May", "Jun"};
        XAxis xAxis = mChart.getXAxis();
        xAxis.setValueFormatter(new MyXAxisValueFormatter(months));

    }
    /** set data to simple bar chart */
    private void setSimpleBarChartData(ArrayList<BarEntry> barEntries) {
        barEntries.add(new BarEntry(1,40f));
        barEntries.add(new BarEntry(2,44f));
        barEntries.add(new BarEntry(3,30f));
        barEntries.add(new BarEntry(4,36f));
    }

    /** MULTI BAR CHART */
    /**
     * create multi bar chart
     * @param mChart BarChart from layout.
     * @param multiBarEntries1 array of BarEntry with the information to display in the first column.
     * @param multiBarEntries2 array of BarEntry with the information to display in the second column.
     */
    private void createMultiBarChart(BarChart mChart,ArrayList<BarEntry> multiBarEntries1, ArrayList<BarEntry> multiBarEntries2) {
        mChart.setDrawBarShadow(false);
        mChart.setDrawValueAboveBar(true);
        mChart.setMaxVisibleValueCount(50);
        mChart.setPinchZoom(false);
        mChart.setDrawGridBackground(true);
        mChart.getDescription().setEnabled(false);


        BarDataSet barDataSet= new BarDataSet(multiBarEntries1 , "Data set1");
        barDataSet.setColors(ColorTemplate.COLORFUL_COLORS);

        BarDataSet barDataSet1= new BarDataSet(multiBarEntries2 , "Data set2");
        barDataSet1.setColors(ColorTemplate.COLORFUL_COLORS);

        BarData data=new BarData(barDataSet, barDataSet1);

        float groupSpace = 0.1f;
        float barSpace = 0.02f;
        float bandwidth = 0.43f;

        mChart.setData(data);

        data.setBarWidth(bandwidth);
        mChart.groupBars(0,groupSpace,barSpace);



        /** It suppose to change the tags on the xAxis,
         * but there is a problem with the implementation of IAxisValueFormatter class*/
        String[] months = new String[]{"Jan", "Feb", "Mar", "April", "May", "Jun"};
        XAxis xAxis = mChart.getXAxis();
        xAxis.setValueFormatter(new MyXAxisValueFormatter(months));


        xAxis.setPosition(XAxis.XAxisPosition.BOTH_SIDED);
        xAxis.setGranularity(1);
        xAxis.setCenterAxisLabels(true);
        xAxis.setAxisMinimum(0);
    }

    /** create multi bar chart data */
    private void setMultiBarChartData(ArrayList<BarEntry> multiBarEntries1, ArrayList<BarEntry> multiBarEntries2) {

        multiBarEntries1.add(new BarEntry(1,48f));
        multiBarEntries1.add(new BarEntry(2,63f));
        multiBarEntries1.add(new BarEntry(3,21f));
        multiBarEntries1.add(new BarEntry(4,37f));

        multiBarEntries2.add(new BarEntry(1,44f));
        multiBarEntries2.add(new BarEntry(2,54f));
        multiBarEntries2.add(new BarEntry(3,68f));
        multiBarEntries2.add(new BarEntry(4,21f));
    }


    /** caused me trouble, I'm not sure how to implement this class. */
    public class MyXAxisValueFormatter extends ValueFormatter implements IAxisValueFormatter {

        private String[] mValue;
        public MyXAxisValueFormatter(String[] values){
            this.mValue=values;
        }

        @Override
        public String getFormattedValue(float value, AxisBase axis) {
            return mValue[(int)value];
        }
    }

    /** SIMPLE LINE CHART */
    /**
     * create simple line chart.
     * @param mChart LineChart from layout.
     * @param yValues array of Entry with the information to display in the chart.
     */
    void createSimpleLineChart(LineChart mChart,ArrayList<Entry> yValues ){

        mChart.setDragEnabled(true);
        mChart.setScaleEnabled(false);
        mChart.getDescription().setEnabled(false);

        LineDataSet set1 = new LineDataSet(yValues, "Data set 1");

        set1.setFillAlpha(110);

        set1.setColor(Color.RED);
        set1.setLineWidth(3f);
        set1.setValueTextSize(20f);
        set1.setValueTextColor(Color.GREEN);

        ArrayList<ILineDataSet> dataSets= new ArrayList<>();
        dataSets.add(set1);

        LineData data = new LineData(dataSets);

        mChart.setData(data);
    }

    /** create data for simple line chart */
    private void setSimpleLineChartData(ArrayList<Entry> yValues){
        yValues.add(new Entry(0,10f));
        yValues.add(new Entry(1,20f));
        yValues.add(new Entry(2,10f));
        yValues.add(new Entry(3,20f));
        yValues.add(new Entry(4,10f));
        yValues.add(new Entry(5,20f));
        yValues.add(new Entry(6,10f));

    }

    /** PIE CHART */
    /**
     * create pie chart.
     * @param pieChart PieChart from layout.
     * @param yValues array of PieEntry with the information to display in the chart.
     */
    private void createPieChart(PieChart pieChart , ArrayList<PieEntry> yValues) {

        pieChart.setUsePercentValues(true);
        pieChart.getDescription().setEnabled(false);
        pieChart.setExtraOffsets(5 , 10 , 5 ,5 );
        pieChart.getDescription().setEnabled(false);

        //smoothness of the spin
        pieChart.setDragDecelerationFrictionCoef(0.99f);

        //animation of loading chart
        pieChart.animateY(1000,Easing.EaseInOutCubic);

        // pie with hole inside or full pie
        pieChart.setDrawHoleEnabled(true);
        pieChart.setTransparentCircleRadius(61f);


        PieDataSet dataSet= new PieDataSet(yValues,"Countries");
        dataSet.setSliceSpace(3f);
        dataSet.setSelectionShift(5f);
        dataSet.setColors(ColorTemplate.JOYFUL_COLORS);

        PieData data = new PieData(dataSet);
        data.setValueTextSize(10f);
        data.setValueTextColor(Color.RED);

        pieChart.setData(data);
    }

    /** create data for pie chart */
    private void setPieChartData(ArrayList<PieEntry> yValues){
        yValues.add(new PieEntry(28f, "Israel"));
        yValues.add(new PieEntry(5f, "USA"));
        yValues.add(new PieEntry(4f, "UK"));
        yValues.add(new PieEntry(4f, "India"));
        yValues.add(new PieEntry(3f, "Russia"));
        yValues.add(new PieEntry(2f, "Japan"));

    }

    /** MULTI LINE CHART */
    /**
     * create multi line chart
     * @param mChart LineChart from layout.
     * @param yVals1 array of Entry with the information to display in the first line.
     * @param yVals2 array of Entry with the information to display in the second line.
     * @param yVals3 array of Entry with the information to display in the third line.
     */
    private void createMultiLineChart(LineChart mChart ,ArrayList<Entry> yVals1, ArrayList<Entry> yVals2,ArrayList<Entry> yVals3 ) {

        mChart.getDescription().setEnabled(false);

        LineDataSet set1, set2, set3;
        set1 = new LineDataSet(yVals1, "Data set1");
        set1.setColor(Color.RED);
        set1.setDrawCircles(false);
        set1.setLineWidth(3f);

        set2 = new LineDataSet(yVals2, "Data set2");
        set2.setColor(Color.GREEN);
        set2.setDrawCircles(false);
        set2.setLineWidth(3f);

        set3 = new LineDataSet(yVals3, "Data set3");
        set3.setColor(Color.GRAY);
        set3.setDrawCircles(false);
        set3.setLineWidth(3f);

        LineData data = new LineData(set1, set2, set3);
        mChart.setData(data);
    }

    /** create data for multi line chart */
    private void setMultiLineChartData(ArrayList<Entry> yVals1, ArrayList<Entry> yVals2, ArrayList<Entry> yVals3) {
        int count =40;
        int range=60;
        for (int i=0; i<count; i++){
            float val = (float) (Math.random()*range)+250;
            yVals1.add(new Entry(i,val));
            val = (float) (Math.random()*range)+150;
            yVals2.add(new Entry(i,val));
            val = (float) (Math.random()*range)+50;
            yVals3.add(new Entry(i,val));
        }
    }


}

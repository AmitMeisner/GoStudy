package com.example.goStudy;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

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

        CreateLineChart();
        CreateLineChart2();
        CreatePieChart();
        CreateBarChart();
        CreateBarChart2();
        CreateLineChart3();
        CreateBarChart4();




    }

    /** STACKED BARD CHART */
    private void CreateBarChart4() {
        BarChart mChart=(BarChart) findViewById(R.id.StackedBarChart);

        mChart.setMaxVisibleValueCount(40);

        StackedChartData(10, mChart);
    }

    private void StackedChartData(int count, BarChart mChart) {

        ArrayList<BarEntry> yValues = new ArrayList<>();

        for(int i=0; i<count; i++){
            float val1 =  (float) (Math.random()+count)+20;
            float val2 =  (float) (Math.random()+count)+10;
            float val3 =  (float) (Math.random()+count)+30;

            yValues.add(new BarEntry(i ,new float[]{val1,val2, val3}));
        }

        BarDataSet set1;
        set1 = new BarDataSet(yValues,"Statistic of USA");
        set1.setDrawIcons(false);
        set1.setStackLabels(new String[]{"Children", "Adults", "Elders"});
        set1.setColors(ColorTemplate.COLORFUL_COLORS);

        BarData data = new BarData(set1);
        /** problem with setting xAxis tags */
//        data.setValueFormatter(new MyXAxisValueFormatter());

        mChart.setData(data);
        mChart.setFitBars(true);
        mChart.invalidate();
        mChart.getDescription().setEnabled(false);



    }


    /** SMOOTH LINE CHART */
    private void CreateLineChart2() {
        LineChart mChart = findViewById(R.id.SmoothLineChart);

//        mChart.setOnChartGestureListener(Practice.this);
//        mChart.setOnChartValueSelectedListener(Practice.this);

        mChart.setDragEnabled(true);
        mChart.setScaleEnabled(false);

        ArrayList<Entry> yValues= new ArrayList<Entry>();

        yValues.add(new Entry(0,10f));
        yValues.add(new Entry(1,20f));
        yValues.add(new Entry(2,10f));
        yValues.add(new Entry(3,20f));
        yValues.add(new Entry(4,10f));
        yValues.add(new Entry(5,20f));
        yValues.add(new Entry(6,10f));


        LineDataSet set1 = new LineDataSet(yValues, "Data set 1");

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

    /** BAR CHART */
    private void CreateBarChart() {
        BarChart barChart1 = (BarChart) findViewById(R.id.BarChart);

        barChart1.setDrawBarShadow(false);
        barChart1.setDrawValueAboveBar(true);
        barChart1.setMaxVisibleValueCount(50);
        barChart1.setPinchZoom(false);
        barChart1.setDrawGridBackground(true);

        ArrayList<BarEntry> barEntries= new ArrayList<>();

        barEntries.add(new BarEntry(1,40f));
        barEntries.add(new BarEntry(2,44f));
        barEntries.add(new BarEntry(3,30f));
        barEntries.add(new BarEntry(4,36f));

        BarDataSet barDataSet= new BarDataSet(barEntries , "Data set1");
        barDataSet.setColors(ColorTemplate.COLORFUL_COLORS);

        BarData data=new BarData(barDataSet);
        data.setBarWidth(0.9f);

        barChart1.setData(data);
        barChart1.animateY(1000, Easing.EaseInOutSine);

        /** It suppose to change the tags on the xAxis,
         * but there is a problem with the implementation of IAxisValueFormatter class*/
        String[] months = new String[]{"Jan", "Feb", "Mar", "April", "May", "Jun"};
        XAxis xAxis = barChart1.getXAxis();
        xAxis.setValueFormatter(new MyXAxisValueFormatter(months));

    }

    /** MULTI BAR CHART */
    private void CreateBarChart2() {
        BarChart barChart2 = (BarChart) findViewById(R.id.BarChart2);

        barChart2.setDrawBarShadow(false);
        barChart2.setDrawValueAboveBar(true);
        barChart2.setMaxVisibleValueCount(50);
        barChart2.setPinchZoom(false);
        barChart2.setDrawGridBackground(true);

        ArrayList<BarEntry> barEntries= new ArrayList<>();

        barEntries.add(new BarEntry(1,48f));
        barEntries.add(new BarEntry(2,63f));
        barEntries.add(new BarEntry(3,21f));
        barEntries.add(new BarEntry(4,37f));

        ArrayList<BarEntry> barEntries1= new ArrayList<>();
        //define the second set
        barEntries1.add(new BarEntry(1,44f));
        barEntries1.add(new BarEntry(2,54f));
        barEntries1.add(new BarEntry(3,68f));
        barEntries1.add(new BarEntry(4,21f));

        BarDataSet barDataSet= new BarDataSet(barEntries , "Data set1");
        barDataSet.setColors(ColorTemplate.COLORFUL_COLORS);

        BarDataSet barDataSet1= new BarDataSet(barEntries1 , "Data set2");
        barDataSet1.setColors(ColorTemplate.COLORFUL_COLORS);

        BarData data=new BarData(barDataSet, barDataSet1);

        float groupSpace = 0.1f;
        float barSpace = 0.02f;
        float bandwidth = 0.43f;

        barChart2.setData(data);

        data.setBarWidth(bandwidth);
        barChart2.groupBars(0,groupSpace,barSpace);



        /** It suppose to change the tags on the xAxis,
         * but there is a problem with the implementation of IAxisValueFormatter class*/
        String[] months = new String[]{"Jan", "Feb", "Mar", "April", "May", "Jun"};
        XAxis xAxis = barChart2.getXAxis();
        xAxis.setValueFormatter(new MyXAxisValueFormatter(months));


        xAxis.setPosition(XAxis.XAxisPosition.BOTH_SIDED);
        xAxis.setGranularity(1);
        xAxis.setCenterAxisLabels(true);
        xAxis.setAxisMinimum(0);




    }

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

    /** LINE CHART */
    void CreateLineChart(){
        LineChart mChart = findViewById(R.id.LineChart);

//        mChart.setOnChartGestureListener(Practice.this);
//        mChart.setOnChartValueSelectedListener(Practice.this);

        mChart.setDragEnabled(true);
        mChart.setScaleEnabled(false);

        ArrayList<Entry> yValues= new ArrayList<Entry>();

        yValues.add(new Entry(0,10f));
        yValues.add(new Entry(1,20f));
        yValues.add(new Entry(2,10f));
        yValues.add(new Entry(3,20f));
        yValues.add(new Entry(4,10f));
        yValues.add(new Entry(5,20f));
        yValues.add(new Entry(6,10f));


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

    /** PIE CHART */
    private void CreatePieChart() {
        PieChart pieChart = (PieChart) findViewById(R.id.PieChart);

        pieChart.setUsePercentValues(true);
        pieChart.getDescription().setEnabled(false);
        pieChart.setExtraOffsets(5 , 10 , 5 ,5 );

        //smoothness of the spin
        pieChart.setDragDecelerationFrictionCoef(0.99f);

        //animation of loading chart
        pieChart.animateY(1000,Easing.EaseInOutCubic);

        // pie with hole inside or full pie
        pieChart.setDrawHoleEnabled(true);
        pieChart.setTransparentCircleRadius(61f);



        ArrayList<PieEntry> yValues = new ArrayList<>();

        yValues.add(new PieEntry(28f, "Israel"));
        yValues.add(new PieEntry(5f, "USA"));
        yValues.add(new PieEntry(4f, "UK"));
        yValues.add(new PieEntry(4f, "India"));
        yValues.add(new PieEntry(3f, "Russia"));
        yValues.add(new PieEntry(2f, "Japan"));

        PieDataSet dataSet= new PieDataSet(yValues,"Countries");
        dataSet.setSliceSpace(3f);
        dataSet.setSelectionShift(5f);
        dataSet.setColors(ColorTemplate.JOYFUL_COLORS);

        PieData data = new PieData(dataSet);
        data.setValueTextSize(10f);
        data.setValueTextColor(Color.RED);

        pieChart.setData(data);
    }

    /** MULTI LINE CHART */
    private void CreateLineChart3() {
            LineChart mChart = findViewById(R.id.MultiLineChart);
            MultiLineChartData(40,60, mChart);
    }
    private void MultiLineChartData(int count, int range, LineChart mChart){

        ArrayList<Entry> yVals1 =  new ArrayList<>();
        for (int i=0; i<count; i++){
            float val = (float) (Math.random()*range)+250;
            yVals1.add(new Entry(i,val));
        }

        ArrayList<Entry> yVals2=  new ArrayList<>();
        for (int i=0; i<count; i++){
            float val = (float) (Math.random()*range)+150;
            yVals2.add(new Entry(i,val));
        }

        ArrayList<Entry> yVals3 =  new ArrayList<>();
        for (int i=0; i<count; i++){
            float val = (float) (Math.random()*range)+50;
            yVals3.add(new Entry(i,val));
        }

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


}

<template>
    <div class="col-lg-6">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Les doléances <span>/mensuelle</span></h5>
                <div class="filter-year">
                    <input class="form-control" v-model.number="doleance.selectAnnee" type="number"/>
                </div>
                <apexchart width="500" type="bar" :options="doleance.chartOptions" :series="doleance.series"></apexchart>
            </div>
        </div>
    </div>
    <div class="col-lg-6">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Les candidatures de stages <span>/annuelle</span></h5>
                <div class="filter-year">
                    <input class="form-control" v-model.number="stage.selectAnnee" type="number"/>
                </div>
                <apexchart width="500"  type="bar" :options="stage.chartOptions" :series="stage.series"></apexchart>
            </div>
        </div>
    </div>
</template>

<script>
    // import Name from '@/components/Name.vue';
    // import apexcharts from "apexcharts"
    import VueApexCharts from "vue3-apexcharts";
    import chart from '../../api/chart.js'
    export default {
        name: 'Chart',
        components: {
            apexchart: VueApexCharts,
        },
        props:{
            autorite:{
                type: Object
            }
        },
        data() {
            return {
                // autorite: JSON.parse(localStorage.getItem('autorite')).db,
                doleance : {
                    selectAnnee: `${new Date(Date.now()).getFullYear()}`,
                    chartOptions: {
                        chart: {
                            id: 'basic-bar'
                        },
                        plotOptions: {
                            bar: {
                                borderRadius: 10,
                                dataLabels: {
                                    position: 'top', // top, center, bottom
                                },
                            }
                        },
                        animations: {
                            enabled: true,
                            easing: 'easeinout',
                            speed: 500,
                            animateGradually: {
                                enabled: true,
                                delay: 150
                            },
                            dynamicAnimation: {
                                enabled: true,
                                speed: 350
                            }
                        },
                        xaxis: {
                            // categories: [1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998]
                            crosshairs: {
                                fill: {
                                    type: 'gradient',
                                    gradient: {
                                        colorFrom: '#D8E3F0',
                                        colorTo: '#BED1E6',
                                        stops: [0, 100],
                                        opacityFrom: 0.4,
                                        opacityTo: 0.5,
                                    }
                                }
                            },
                            
                        }
                    },
                    series: [
                    {
                        name: 'Doléance',
                        data: []
                        // data: 'Chargement...'
                    }
                ]
                },
                
                stage: {
                    selectAnnee: `${new Date(Date.now()).getFullYear()}`,
                    series: [
                        {
                            name: "Stages",
                            // data: [400, 430, 448, 470, 540, 580, 690, 1100, 1200, 1380]
                            data:[]
                        },
                    ],
                    chartOptions: {
                        chart: {
                            type: 'bar',
                            // height: 350
                        },
                        plotOptions: {
                            bar: {
                                barHeight: '100%',
                                distributed: true,
                                horizontal: true,
                                dataLabels: {
                                    position: 'bottom'
                                },
                            }
                        },
                        dataLabels: {
                            enabled: true,
                            textAnchor: 'start',
                            style: {
                                colors: ['#fff']
                            },
                            formatter: function (val, opt) {
                                return opt.w.globals.labels[opt.dataPointIndex] + ":  " + val
                            },
                            offsetX: 0,
                            dropShadow: {
                                enabled: true
                            }
                        },
                        stroke: {
                            width: 1,
                            colors: ['#fff']
                        },
                        colors: ['#008ffbd9'],
                        yaxis: {
                            labels: {
                                show: false
                            }
                        },
                        legend: {
                            show: false
                        },

                        tooltip: {
                            theme: 'dark',
                            x: {
                                show: false
                            },
                            y: {
                                title: {
                                    formatter: function () {
                                        return ''
                                    }
                                }
                            }
                        }

                    },




                },

            }
        },
        watch:{
          'doleance.selectAnnee': async function (input){
            const current_year = new Date(Date.now()).getFullYear()
            this.doleance.series[0].data = await chart.dashboard_doleance({annee: input, id_autorite: this.autorite.child_id})
          },

          'stage.selectAnnee': async function (input){
            const current_year = new Date(Date.now()).getFullYear()
            this.stage.series[0].data = await chart.dashboard_stage({annee: input, id_autorite: this.autorite.child_id})
          }
        },
        async updated(){
            // console.log(this.autorite.child_id)
            this.doleance.series[0].data = await chart.dashboard_doleance({id_autorite: this.autorite.child_id, annee: this.doleance.selectAnnee})
            this.stage.series[0].data = await chart.dashboard_stage({id_autorite: this.autorite.child_id, annee: this.stage.selectAnnee})

            // console.log(chart.dashboard_doleance())
        },
        
    };
</script>

<style>
    .filter-year {
        /* padding-left: 79%; */
        padding-right: 85%;
        /* color:#008ffbd9 */
    }
</style>

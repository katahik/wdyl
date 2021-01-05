<template>
  <div id="app">
    <div>
      <input v-model="name" placeholder="name">
      <input v-model="period_start" placeholder="period_start">
      <input v-model="period_end" placeholder="period_end">
      <button @click="addCompetition">addCompetition</button>
    </div>
    <ul>
      <li v-for="competition in competitions" :key="competition.id">
        {{competition.name}}:{{competition.period_start}}〜{{competition.period_end}}
      </li>
    </ul>
  </div>
</template>

<script>
// axiosのモジュールをインポート
import axios from 'axios';
export default {
  data: function () {
    return {
      competitions: "competitions",
      name: '',
      period_start: '',
      period_end: '',
    }
  },
  mounted() {
    this.setCompetition();
  },
  methods:{
    // setCompetitionsメソッドを定義
    setCompetition: function(){
      // GETメソッドでapi/competitionsとしたとき
      axios.get('/api/competitions')
          // 成功したら、
      .then(response=>(
          // Axiosで呼び出したAPIの情報をcompetitionsに格納
          this.competitions = response.data
      ))
    },
    addCompetition: function (){
      axios.post('/api/competitions',{
        title:this.name,
        period_start:this.period_start,
        period_end:this.period_end,
      })
      .then(response=>(
          this.setCompetition()
      ));
    }
  }

}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

import React from 'react'
import {useEffect,useState} from 'react'
import {Link} from 'react-router-dom'

import HeroCard from '../components/heroCard'

import {Box,Text,Button} from '@chakra-ui/react'

import {getMyHeroes} from '../contracts/functions'


interface myHeroesProps {

}

const MyHeroes: React.FC<myHeroesProps> = () => {
    const [myHeroes, setMyHeroes] = useState<any[]>([])
    useEffect(()=>{
        const myAddress = sessionStorage.getItem('currentAccount')
        if(myAddress){
            getMyHeroes(myAddress).then(res=>{
                setMyHeroes(res)
            })
        }
    },[])
    return (
        <>  
            <Box w="100%" display="flex" flexDirection="column" justifyContent="center" alignItems="center" >
                <Text fontSize="3xl" fontWeight="bold" mt={5}>
                    My Heroes
                    <Link to="/my/cards">
                        <Button size="md" ml={10} >Show my Summon Cards</Button>
                    </Link>
                </Text>
                <Box w="80%" display="flex" flexDirection="row" alignItems="center" justifyContent="flex-start" flexWrap="wrap" mx="auto">
                    {myHeroes.map((hero,index)=>{
                        return (<HeroCard key={index} hero={hero} />)
                    })}
                </Box>
            </Box>
        </>
    );
}

export default MyHeroes;
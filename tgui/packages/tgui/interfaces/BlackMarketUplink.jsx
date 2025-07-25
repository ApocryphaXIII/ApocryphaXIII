import {
  AnimatedNumber,
  Box,
  Button,
  Flex,
  Modal,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import { formatMoney } from 'tgui-core/format';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const BlackMarketUplink = (props) => {
  const { act, data } = useBackend();
  const {
    categories = [],
    markets = [],
    items = [],
    money,
    viewing_market,
    viewing_category,
  } = data;
  return (
    <Window width={600} height={480} theme="hackerman" resizable>
      <ShipmentSelector />
      <Window.Content scrollable>
        <Section
          title="Black Market Uplink"
          buttons={
            <Box inline bold>
              <AnimatedNumber
                value={money}
                format={(value) => formatMoney(value) + ' cr'}
              />
            </Box>
          }
        />
        <Tabs>
          {markets.map((market) => (
            <Tabs.Tab
              key={market.id}
              selected={market.id === viewing_market}
              onClick={() =>
                act('set_market', {
                  market: market.id,
                })
              }
            >
              {market.name}
            </Tabs.Tab>
          ))}
        </Tabs>
        <Flex>
          <Flex.Item>
            <Tabs vertical>
              {categories.map((category) => (
                <Tabs.Tab
                  key={category}
                  mt={0.5}
                  selected={viewing_category === category}
                  onClick={() =>
                    act('set_category', {
                      category: category,
                    })
                  }
                >
                  {category}
                </Tabs.Tab>
              ))}
            </Tabs>
          </Flex.Item>
          <Flex.Item grow={1} basis={0}>
            {items.map((item) => (
              <Box key={item.name} className="candystripe" p={1} pb={2}>
                <Stack align="baseline">
                  <Stack.Item grow bold>
                    {item.name}
                  </Stack.Item>
                  <Stack.Item color="label">
                    {item.amount ? item.amount + ' in stock' : 'Out of stock'}
                  </Stack.Item>
                  <Stack.Item>{formatMoney(item.cost) + ' cr'}</Stack.Item>
                  <Stack.Item>
                    <Button
                      content="Buy"
                      disabled={!item.amount || item.cost > money}
                      onClick={() =>
                        act('select', {
                          item: item.id,
                        })
                      }
                    />
                  </Stack.Item>
                </Stack>
                {item.desc}
              </Box>
            ))}
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};

const ShipmentSelector = (props) => {
  const { act, data } = useBackend();
  const { buying, ltsrbt_built, money } = data;
  if (!buying) {
    return null;
  }
  const deliveryMethods = data.delivery_methods.map((method) => {
    const description = data.delivery_method_description[method.name];
    return {
      ...method,
      description,
    };
  });
  return (
    <Modal textAlign="center">
      <Flex mb={1}>
        {deliveryMethods.map((method) => {
          if (method.name === 'LTSRBT' && !ltsrbt_built) {
            return null;
          }
          return (
            <Flex.Item key={method.name} mx={1} width="250px">
              <Box fontSize="30px">{method.name}</Box>
              <Box mt={1}>{method.description}</Box>
              <Button
                mt={2}
                content={formatMoney(method.price) + ' cr'}
                disabled={money < method.price}
                onClick={() =>
                  act('buy', {
                    method: method.name,
                  })
                }
              />
            </Flex.Item>
          );
        })}
      </Flex>
      <Button content="Cancel" color="bad" onClick={() => act('cancel')} />
    </Modal>
  );
};
